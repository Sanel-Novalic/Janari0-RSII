using Janari0.EmailProvider;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddTransient<IEmailService, EmailService>();
builder.Services.AddHostedService<BackgroundEmailService>();
builder.Services.AddLogging();

var app = builder.Build();

app.Run();
