using Janari0.Services.Context;
using Janari0.Services.IServices;
using Janari0.Services.Services;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers().AddNewtonsoftJson(options => options.SerializerSettings.ReferenceLoopHandling =
        Newtonsoft.Json.ReferenceLoopHandling.Ignore);
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen (options => { options.CustomSchemaIds(type => type.ToString()); });
builder.Services.AddTransient<IProductsSaleService, ProductsSaleService>();
builder.Services.AddTransient<IProductsService, ProductsService>();
builder.Services.AddTransient<IUsersService, UsersService>();
builder.Services.AddTransient<IPhotoService, PhotoService>();
builder.Services.AddTransient<ILocationService, LocationService>();
builder.Services.AddAutoMapper(typeof(IUsersService));

builder.Services.AddDbContext<Janari0Context>(options => options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseDeveloperExceptionPage();

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();

