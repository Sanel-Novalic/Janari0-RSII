using Janari0.Model;

namespace Janari0.Services.IServices
{
    public interface IPaymentService
    {
        Payment BeginTransaction(Payment payment);
        Order SaveTransaction(int orderId, decimal loyaltyPoints);

    }
}
