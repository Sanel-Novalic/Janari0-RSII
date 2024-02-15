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
        public async Task<Model.Payment> BeginTransaction([FromBody] Model.Payment payment)
        {
            return await PaymentService.BeginTransaction(payment);
        }

        [HttpPost("SaveTransaction")]
        public async Task<Model.Order?> SaveTransaction(int orderId, decimal loyaltyPoints)
        {
            return await PaymentService.SaveTransaction(orderId, loyaltyPoints);
        }
    }
}
