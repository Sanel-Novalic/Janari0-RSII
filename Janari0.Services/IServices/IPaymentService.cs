using Janari0.Model;

namespace Janari0.Services.IServices
{
    public interface IPaymentService
    {
        Task<Payment> BeginTransaction(Payment payment);
        Task<Order?> SaveTransaction(int orderId, decimal loyaltyPoints);
    }
}
