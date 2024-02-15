using Janari0.Model;

namespace Janari0.Services.IServices
{
    public interface IEmailProviderService
    {
        Task SendMessage(EmailMessage message, string topic);
    }
}
