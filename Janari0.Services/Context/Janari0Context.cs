using System;
using System.Collections.Generic;
using Janari0.Services.Database;
using Microsoft.EntityFrameworkCore;

namespace Janari0.Services.Context;

public partial class Janari0Context : DbContext
{
    public Janari0Context(DbContextOptions<Janari0Context> options)
        : base(options)
    {
    }

    public virtual DbSet<Buyer> Buyers { get; set; }

    public virtual DbSet<Location> Locations { get; set; }

    public virtual DbSet<Order> Orders { get; set; }

    public virtual DbSet<OrderItem> OrderItems { get; set; }

    public virtual DbSet<Output> Outputs { get; set; }

    public virtual DbSet<OutputItem> OutputItems { get; set; }

    public virtual DbSet<Photo> Photos { get; set; }

    public virtual DbSet<Product> Products { get; set; }

    public virtual DbSet<ProductsSale> ProductsSales { get; set; }

    public virtual DbSet<Seller> Sellers { get; set; }

    public virtual DbSet<User> Users { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Buyer>(entity =>
        {
            entity.HasKey(e => e.BuyerId).HasName("PK__Buyer__4B81C1CA94CF1C1C");

            entity.ToTable("Buyer");

            entity.Property(e => e.BuyerId).HasColumnName("BuyerID");
            entity.Property(e => e.ProductSaleId).HasColumnName("ProductSaleID");
            entity.Property(e => e.UserId).HasColumnName("UserID");

            entity.HasOne(d => d.ProductSale).WithMany(p => p.Buyers)
                .HasForeignKey(d => d.ProductSaleId)
                .HasConstraintName("FK_Buyer_ProductsSale");

            entity.HasOne(d => d.User).WithMany(p => p.Buyers)
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("FK_Buyer_Users");
        });

        modelBuilder.Entity<Location>(entity =>
        {
            entity.HasKey(e => e.LocationId).HasName("PK__Location__E7FEA477CE391E6B");

            entity.Property(e => e.LocationId).HasColumnName("LocationID");
            entity.Property(e => e.Latitude).HasColumnType("decimal(18, 15)");
            entity.Property(e => e.Longitude).HasColumnType("decimal(18, 15)");
        });

        modelBuilder.Entity<Order>(entity =>
        {
            entity.HasKey(e => e.OrderId).HasName("PK__Orders__C3905BAFEE4C1F4C");

            entity.Property(e => e.OrderId).HasColumnName("OrderID");
            entity.Property(e => e.BuyerId).HasColumnName("BuyerID");
            entity.Property(e => e.Date).HasColumnType("datetime");
            entity.Property(e => e.OrderNumber).HasMaxLength(40);

            entity.HasOne(d => d.Buyer).WithMany(p => p.Orders)
                .HasForeignKey(d => d.BuyerId)
                .HasConstraintName("FK_Orders_Buyer");
        });

        modelBuilder.Entity<OrderItem>(entity =>
        {
            entity.HasKey(e => e.OrderItemId).HasName("PK__OrderIte__57ED06A1F935D222");

            entity.Property(e => e.OrderItemId).HasColumnName("OrderItemID");
            entity.Property(e => e.OrderId).HasColumnName("OrderID");
            entity.Property(e => e.ProductSaleId).HasColumnName("ProductSaleID");

            entity.HasOne(d => d.Order).WithMany(p => p.OrderItems)
                .HasForeignKey(d => d.OrderId)
                .HasConstraintName("FK_OrderItems_Orders");

            entity.HasOne(d => d.ProductSale).WithMany(p => p.OrderItems)
                .HasForeignKey(d => d.ProductSaleId)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK_OrderItems_ProductsSale");
        });

        modelBuilder.Entity<Output>(entity =>
        {
            entity.HasKey(e => e.OutputId).HasName("PK__Output__CE760946B23FB18C");

            entity.ToTable("Output");

            entity.Property(e => e.OutputId).HasColumnName("OutputID");
            entity.Property(e => e.BuyerId).HasColumnName("BuyerID");
            entity.Property(e => e.Date).HasColumnType("datetime");
            entity.Property(e => e.OrderId).HasColumnName("OrderID");
            entity.Property(e => e.PaymentMethod).HasMaxLength(40);
            entity.Property(e => e.ReceiptNumber).HasMaxLength(40);

            entity.HasOne(d => d.Buyer).WithMany(p => p.Outputs)
                .HasForeignKey(d => d.BuyerId)
                .HasConstraintName("FK_Output_Buyer");

            entity.HasOne(d => d.Order).WithMany(p => p.Outputs)
                .HasForeignKey(d => d.OrderId)
                .HasConstraintName("FK_Output_Orders");
        });

        modelBuilder.Entity<OutputItem>(entity =>
        {
            entity.HasKey(e => e.OutputItemId).HasName("PK__OutputIt__29975D19564085A6");

            entity.Property(e => e.OutputItemId).HasColumnName("OutputItemID");
            entity.Property(e => e.OutputId).HasColumnName("OutputID");
            entity.Property(e => e.ProductSaleId).HasColumnName("ProductSaleID");
            entity.Property(e => e.SellerId).HasColumnName("SellerID");

            entity.HasOne(d => d.Output).WithMany(p => p.OutputItems)
                .HasForeignKey(d => d.OutputId)
                .HasConstraintName("FK_OutputItems_Output");

            entity.HasOne(d => d.ProductSale).WithMany(p => p.OutputItems)
                .HasForeignKey(d => d.ProductSaleId)
                .HasConstraintName("FK_OutputItems_ProductsSale");

            entity.HasOne(d => d.Seller).WithMany(p => p.OutputItems)
                .HasForeignKey(d => d.SellerId)
                .HasConstraintName("FK_OutputItems_Seller");
        });

        modelBuilder.Entity<Photo>(entity =>
        {
            entity.HasKey(e => e.PhotoId).HasName("PK__Photos__21B7B5828B3E101A");

            entity.Property(e => e.PhotoId).HasColumnName("PhotoID");
            entity.Property(e => e.ProductId).HasColumnName("ProductID");

            entity.HasOne(d => d.Product).WithMany(p => p.Photos)
                .HasForeignKey(d => d.ProductId)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK_Photos_Products");
        });

        modelBuilder.Entity<Product>(entity =>
        {
            entity.Property(e => e.ProductId).HasColumnName("ProductID");
            entity.Property(e => e.ExpirationDate).HasColumnType("datetime");
            entity.Property(e => e.Name).HasMaxLength(50);
            entity.Property(e => e.UserId).HasColumnName("UserID");

            entity.HasOne(d => d.User).WithMany(p => p.Products)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Products_Users");
        });

        modelBuilder.Entity<ProductsSale>(entity =>
        {
            entity.HasKey(e => e.ProductSaleId).HasName("PK__Products__6723C2D1C83E4825");

            entity.ToTable("ProductsSale");

            entity.Property(e => e.ProductSaleId).HasColumnName("ProductSaleID");
            entity.Property(e => e.Description).HasMaxLength(200);
            entity.Property(e => e.LocationId).HasColumnName("LocationID");
            entity.Property(e => e.Price).HasMaxLength(10);
            entity.Property(e => e.ProductId).HasColumnName("ProductID");

            entity.HasOne(d => d.Location).WithMany(p => p.ProductsSales)
                .HasForeignKey(d => d.LocationId)
                .HasConstraintName("FK_ProductsSale_Locations");

            entity.HasOne(d => d.Product).WithMany(p => p.ProductsSales)
                .HasForeignKey(d => d.ProductId)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK_ProductsSale_Products");
        });

        modelBuilder.Entity<Seller>(entity =>
        {
            entity.HasKey(e => e.SellerId).HasName("PK__Seller__7FE3DBA17838C381");

            entity.ToTable("Seller");

            entity.Property(e => e.SellerId).HasColumnName("SellerID");
            entity.Property(e => e.PaypalEmail).HasMaxLength(40);
            entity.Property(e => e.ProductSaleId).HasColumnName("ProductSaleID");
            entity.Property(e => e.UserId).HasColumnName("UserID");

            entity.HasOne(d => d.ProductSale).WithMany(p => p.Sellers)
                .HasForeignKey(d => d.ProductSaleId)
                .HasConstraintName("FK_Seller_ProductsSale");

            entity.HasOne(d => d.User).WithMany(p => p.Sellers)
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("FK_Seller_Users");
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.UserId).HasName("PK__Users__1788CCAC2EA99370");

            entity.Property(e => e.UserId).HasColumnName("UserID");
            entity.Property(e => e.Email).HasMaxLength(20);
            entity.Property(e => e.LocationId).HasColumnName("LocationID");
            entity.Property(e => e.PasswordHash).HasMaxLength(50);
            entity.Property(e => e.PasswordSalt).HasMaxLength(50);
            entity.Property(e => e.PhoneNumber).HasMaxLength(20);
            entity.Property(e => e.Role).HasMaxLength(10);
            entity.Property(e => e.Uid).HasMaxLength(30);
            entity.Property(e => e.Username).HasMaxLength(20);

            entity.HasOne(d => d.Location).WithMany(p => p.Users)
                .HasForeignKey(d => d.LocationId)
                .HasConstraintName("FK_Users_Locations");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
