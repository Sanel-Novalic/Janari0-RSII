using Janari0.Services.IServices;
using Microsoft.AspNetCore.Mvc;

namespace Janari0.Controllers
{
    [ApiController]
    [Route("Payment")]
    public class PaymentController : ControllerBase
    {
        public IPaymentService PaymentService { get; set; }
        public PaymentController(IPaymentService paymentService)
        {
            PaymentService = paymentService;
        }

        [HttpPost("BeginTransaction")]
        public Model.Payment BeginTransaction([FromBody]Model.Payment payment)
        {
            var result = PaymentService.BeginTransaction(payment);
            return result;
        }
        [HttpPost("SaveTransaction")]
        public Model.Order SaveTransaction(int orderId,decimal loyaltyPoints)
        {
            var result = PaymentService.SaveTransaction(orderId,loyaltyPoints);
            return result;
        }

    }
}
