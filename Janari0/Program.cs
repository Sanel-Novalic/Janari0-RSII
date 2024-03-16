using FirebaseAdmin;
using Google.Apis.Auth.OAuth2;
using Janari0;
using Janari0.Services.Context;
using Janari0.Services.IServices;
using Janari0.Services.Services;
using Microsoft.AspNetCore.Authentication;
using Microsoft.EntityFrameworkCore;
using Microsoft.OpenApi.Models;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers().AddNewtonsoftJson(options => options.SerializerSettings.ReferenceLoopHandling = Newtonsoft.Json.ReferenceLoopHandling.Ignore);

builder.Services.AddEndpointsApiExplorer();

builder.Services.AddSwaggerGen(options =>
{
    options.CustomSchemaIds(type => type.ToString());

    options.AddSecurityDefinition(
        "Bearer",
        new OpenApiSecurityScheme
        {
            Description = "JWT Authorization header using the Bearer scheme.",
            Name = "Authorization",
            In = ParameterLocation.Header,
            Type = SecuritySchemeType.Http,
            Scheme = "bearer",
            BearerFormat = "JWT"
        }
    );

    options.AddSecurityRequirement(
        new OpenApiSecurityRequirement
        {
            {
                new OpenApiSecurityScheme
                {
                    Reference = new OpenApiReference { Type = ReferenceType.SecurityScheme, Id = "Bearer" }
                },
                Array.Empty<string>()
            }
        }
    );
});

builder.Services.AddTransient<IProductsSaleService, ProductsSaleService>();
builder.Services.AddTransient<IProductsService, ProductsService>();
builder.Services.AddTransient<IUsersService, UsersService>();
builder.Services.AddTransient<IPhotoService, PhotoService>();
builder.Services.AddTransient<ILocationService, LocationService>();
builder.Services.AddTransient<IBuyersService, BuyersService>();
builder.Services.AddTransient<IOrderItemsService, OrderItemsService>();
builder.Services.AddTransient<IOutputItemsService, OutputItemsService>();
builder.Services.AddTransient<IOrdersService, OrdersService>();
builder.Services.AddTransient<IOutputService, OutputService>();
builder.Services.AddTransient<IPaymentService, PaymentService>();
builder.Services.AddTransient<ISellersService, SellerService>();
builder.Services.AddScoped<IEmailProviderService, EmailProviderService>();
builder.Services.AddAutoMapper(typeof(IUsersService));

builder.Services.AddDbContext<Janari0Context>(options =>
{
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection"));
    options.UseQueryTrackingBehavior(QueryTrackingBehavior.NoTracking);
});

FirebaseApp.Create(new AppOptions { Credential = GoogleCredential.FromFile("firebase.json"), });

builder
    .Services.AddAuthentication(options =>
    {
        options.DefaultAuthenticateScheme = nameof(FirebaseAuthenticationHandler);
        options.DefaultChallengeScheme = nameof(FirebaseAuthenticationHandler);
    })
    .AddScheme<AuthenticationSchemeOptions, FirebaseAuthenticationHandler>(nameof(FirebaseAuthenticationHandler), options => { });

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI(c =>
    {
        c.SwaggerEndpoint("/swagger/v1/swagger.json", "Janari0 API V1");
        c.OAuthAppName("API - Swagger");
        c.OAuthUsePkce();
    });
    app.UseDeveloperExceptionPage();
}

app.UseDeveloperExceptionPage();

app.UseAuthentication();

app.UseAuthorization();

app.MapControllers();

using (var scope = app.Services.CreateScope())
{
    var service = scope.ServiceProvider.GetRequiredService<Janari0Context>();
    service.Database.EnsureDeleted();
    service.Database.Migrate();
}

app.Run();
