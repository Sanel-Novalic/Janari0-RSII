using Janari0.Services;
using Janari0.Services.Database;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen ();
builder.Services.AddTransient<IProductsSaleService, ProductsSaleService>();
builder.Services.AddTransient<IProductsService, ProductsService>();
builder.Services.AddTransient<IUsersService, UsersService>();
builder.Services.AddAutoMapper(typeof(IUsersService));
builder.Services.AddDbContext<Janari0Context>(options => options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));
var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
