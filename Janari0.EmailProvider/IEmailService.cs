namespace Janari0.EmailProvider
{
    public interface IEmailService
    {
        public Task SendEmailAsync(string email, string subject, string message);
    }
}
