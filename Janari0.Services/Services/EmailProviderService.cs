using EasyNetQ;
using Janari0.Model;
using Janari0.Services.IServices;

namespace Janari0.Services.Services
{
    public class EmailProviderService : IEmailProviderService
    {
        private readonly string _rabbitMqConnectionString;

        public EmailProviderService()
        {
            _rabbitMqConnectionString =
                $"host={Environment.GetEnvironmentVariable("RABBITMQ_HOST") ?? "rabbitmq"};"
                + $"virtualHost={Environment.GetEnvironmentVariable("RABBITMQ_VIRTUALHOST") ?? "/"};"
                + $"username={Environment.GetEnvironmentVariable("RABBITMQ_USERNAME") ?? "user"};"
                + $"password={Environment.GetEnvironmentVariable("RABBITMQ_PASSWORD") ?? "password"}";
        }

        public async Task SendMessage(EmailMessage message, string topic)
        {
            var bus = RabbitHutch.CreateBus(_rabbitMqConnectionString);
            await bus.PubSub.PublishAsync(message, topic);
        }
    }
}
