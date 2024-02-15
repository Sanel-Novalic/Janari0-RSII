using EasyNetQ;
using Janari0.EmailProvider;
using Janari0.Model;

public class BackgroundEmailService : BackgroundService
{
    private readonly ILogger _logger;
    private readonly IEmailService _emailService;
    private readonly string _rabbitMqConnectionString;

    public BackgroundEmailService(ILoggerFactory loggerFactory, IEmailService emailService)
    {
        _logger = loggerFactory.CreateLogger<BackgroundEmailService>();
        _emailService = emailService;
        _rabbitMqConnectionString =
            $"host={Environment.GetEnvironmentVariable("RABBITMQ_HOST") ?? "rabbitmq"};"
            + $"virtualHost={Environment.GetEnvironmentVariable("RABBITMQ_VIRTUALHOST") ?? "/"};"
            + $"username={Environment.GetEnvironmentVariable("RABBITMQ_USERNAME") ?? "user"};"
            + $"password={Environment.GetEnvironmentVariable("RABBITMQ_PASSWORD") ?? "password"}";
    }

    protected override Task ExecuteAsync(CancellationToken stoppingToken)
    {
        stoppingToken.ThrowIfCancellationRequested();

        var rabbitMqConnectionString = _rabbitMqConnectionString;
        var bus = RabbitHutch.CreateBus(rabbitMqConnectionString);

        bus.PubSub.SubscribeAsync<EmailMessage>(
            "New_orders",
            async message =>
            {
                try
                {
                    var subject = "You have successfully ordered a product from Janari0!";
                    var body = $"Your order with id {message.Id} on {message.Date} has been successfully confirmed. Your tracking number is: {message.TrackNumber}";
                    await _emailService.SendEmailAsync(message.To, subject, body);
                    _logger.LogInformation($"Email sent: {subject}");
                }
                catch (Exception ex)
                {
                    _logger.LogError(ex, "Failed to send email");
                }
            },
            configuration => configuration.WithTopic("email"),
            cancellationToken: stoppingToken
        );

        return Task.CompletedTask;
    }
}
