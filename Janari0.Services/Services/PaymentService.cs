using AutoMapper;
using Braintree;
using Janari0.Model;
using Janari0.Model.Requests;
using Janari0.Services.Context;
using Janari0.Services.Exceptions;
using Janari0.Services.IServices;
using Janari0.Services.Properties;

namespace Janari0.Services.Services
{
    public class PaymentService : IPaymentService
    {
        public Janari0Context Context;
        public IMapper Mapper;

        public PaymentService(Janari0Context context, IMapper mapper)
        {
            Context = context;
            Mapper = mapper;
        }

        public async Task<Payment> BeginTransaction(Payment payment)
        {
            ProductsSaleService productsSaleService = new ProductsSaleService(Context, Mapper);
            var product = await productsSaleService.GetById(payment.ProductSaleId);

            var gateway = new BraintreeGateway()
            {
                Environment = Braintree.Environment.SANDBOX,
                MerchantId = Resources.PaymentMerchantId,
                PublicKey = Resources.PaymentPublicKey,
                PrivateKey = Resources.PaymentPrivateKey,
            };

            payment.Amount = Convert.ToDecimal(string.Format("{0:0.00}", payment.Amount));

            TransactionRequest request = new TransactionRequest()
            {
                Amount = payment.Amount,
                PaymentMethodNonce = payment.PaymentMethodNonce,
                Options = new TransactionOptionsRequest()
                {
                    SubmitForSettlement = true,
                    PayPal = new TransactionOptionsPayPalRequest()
                    {
                        Description =
                            "This is your confirmation of payment to the Janari0 app for product: " + product.Product.Name + " from seller: " + product.Product.User.Username,
                        PayeeEmail = product.Product.User.Email,
                    }
                },
                TaxAmount = Convert.ToDecimal(0.5),
            };

            var result = gateway.Transaction.Sale(request);

            if (result.IsSuccess())
            {
                payment.Successful = true;
                Context.SaveChanges();
            }
            else if (result.Transaction != null)
            {
                throw new PaymentException(
                    " Transaction Status: "
                        + result.Transaction.Status
                        + "\n"
                        + " Code: "
                        + result.Transaction.ProcessorResponseCode
                        + "\n"
                        + " Text: "
                        + result.Transaction.ProcessorResponseText
                );
            }
            else
            {
                throw new Exception();
            }

            return payment;
        }

        public async Task<Order?> SaveTransaction(int orderId, decimal loyaltyPoints)
        {
            OrdersService orderService = new(Context, Mapper);
            OutputService outputService = new(Context, Mapper);
            OutputItemsService outputItemsService = new(Context, Mapper);
            var order = await orderService.GetById(orderId);
            if (order == null)
            {
                return null;
            }
            Output? insertedOutput = null;

            OutputUpsertRequest output = new OutputUpsertRequest()
            {
                Date = DateTime.Now,
                PaymentMethod = "PayPal",
                BuyerId = order.BuyerId,
                Concluded = true,
                Amount = Convert.ToDecimal(order.Price),
                OrderId = order.OrderId,
                ReceiptNumber = order.OrderNumber + "/" + order.Date.Year.ToString(),
            };
            insertedOutput = await outputService.Insert(output);
            if (insertedOutput != null)
            {
                foreach (var item in order.OrderItems)
                {
                    OutputItemUpsertRequest outputitem =
                        new()
                        {
                            OutputId = insertedOutput.OutputId,
                            ProductId = item.ProductSaleId,
                            Price = Convert.ToDecimal(item.ProductSale.Price),
                            Discount = loyaltyPoints,
                        };
                    await outputItemsService.Insert(outputitem);
                }
            }
            return order;
        }
    }
}
