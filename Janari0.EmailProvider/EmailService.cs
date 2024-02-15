using System.Net;
using System.Net.Mail;
using Microsoft.Extensions.Logging;
using SendGrid;
using SendGrid.Helpers.Mail;

namespace Janari0.EmailProvider
{
    public class EmailService : IEmailService
    {
        private readonly ILogger _logger;
        private readonly string _outlookMail = Environment.GetEnvironmentVariable("OUTLOOK_MAIL") ?? "janari0service@outlook.com";
        private readonly string _encryptedApiKey =
            Environment.GetEnvironmentVariable("ENCRYPTED_API_KEY")
            ?? "58cMEkORy1kZBGheeCEHx5ieoAgcDxO7OQm6HYp7sZ0HdYoTefXmTGQCKc35dEmTf6Gi3BG7PTqIUqsHx7O/GSbvwkJjlAAvgvyl6j0N2Xg=";
        private readonly string _encryptionKey = Environment.GetEnvironmentVariable("ENCRYPTION_KEY") ?? "73Gh30kxP4j7W2nX5Rf8T3vZ20QqM1uY";
        private readonly string _apiKey;

        public EmailService(ILoggerFactory loggerFactory)
        {
            _logger = loggerFactory.CreateLogger<EmailService>();
            _apiKey = EncryptionHelper.DecryptString(_encryptedApiKey, _encryptionKey);
        }

        public async Task SendEmailAsync(string email, string subject, string message)
        {
            try
            {
                var client = new SendGridClient(_apiKey);
                var from = new EmailAddress(_outlookMail, "Janari0");
                var to = new EmailAddress(email, email);
                var plainTextContent = message;
                var htmlContent = $"<p>{plainTextContent}</p>";
                var msg = MailHelper.CreateSingleEmail(from, to, subject, plainTextContent, htmlContent);
                await client.SendEmailAsync(msg);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message);
            }
        }
    }
}
