using Janari0.Services.Context;
using Janari0.Services.IServices;
using Janari0.Services.Services;
using Microsoft.EntityFrameworkCore;
using Microsoft.ML;

var builder = WebApplication.CreateBuilder(args);


builder.Services.AddControllers().AddNewtonsoftJson(options => options.SerializerSettings.ReferenceLoopHandling =
        Newtonsoft.Json.ReferenceLoopHandling.Ignore);

builder.Services.AddEndpointsApiExplorer();

builder.Services.AddSwaggerGen (options => { options.CustomSchemaIds(type => type.ToString()); });

builder.Services.AddTransient<IProductsSaleService, ProductsSaleService>();
builder.Services.AddTransient<IProductsService, ProductsService>();
builder.Services.AddTransient<IUsersService, UsersService>();
builder.Services.AddTransient<IPhotoService, PhotoService>();
builder.Services.AddTransient<ILocationService, LocationService>();
builder.Services.AddTransient<IBuyersService, BuyersService>();
builder.Services.AddTransient<IOrderItemsService, OrderItemsService>();
builder.Services.AddTransient<IOrdersService, OrdersService>();
builder.Services.AddTransient<IOutputService, OutputService>();
builder.Services.AddTransient<IPaymentService, PaymentService>();
builder.Services.AddTransient<ISellersService, SellerService>();
builder.Services.AddAutoMapper(typeof(IUsersService));

builder.Services.AddDbContext<Janari0Context>(options => {
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection"));
    options.UseQueryTrackingBehavior(QueryTrackingBehavior.NoTracking);
});

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseDeveloperExceptionPage();

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

using (var scope = app.Services.CreateScope())
{
    var service = scope.ServiceProvider.GetRequiredService<Janari0Context>();
    service.Database.Migrate();
}

app.Run();

