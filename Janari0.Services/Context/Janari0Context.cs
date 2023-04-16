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

    public virtual DbSet<Location> Locations { get; set; }

    public virtual DbSet<Photo> Photos { get; set; }

    public virtual DbSet<Product> Products { get; set; }

    public virtual DbSet<ProductsSale> ProductsSales { get; set; }

    public virtual DbSet<User> Users { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Location>(entity =>
        {
            entity.HasKey(e => e.LocationId).HasName("PK__Location__E7FEA477CE391E6B");

            entity.Property(e => e.LocationId).HasColumnName("LocationID");
            entity.Property(e => e.Latitude).HasColumnType("decimal(18, 15)");
            entity.Property(e => e.Longitude).HasColumnType("decimal(18, 15)");
        });

        modelBuilder.Entity<Photo>(entity =>
        {
            entity.HasKey(e => e.PhotoId).HasName("PK__Photos__21B7B5828B3E101A");

            entity.Property(e => e.PhotoId).HasColumnName("PhotoID");
            entity.Property(e => e.ProductId).HasColumnName("ProductID");

            entity.HasOne(d => d.Product).WithMany(p => p.Photos)
                .HasForeignKey(d => d.ProductId)
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
            entity.HasKey(e => e.ProductsSaleId).HasName("PK__Products__6723C2D1C83E4825");

            entity.ToTable("ProductsSale");

            entity.Property(e => e.ProductsSaleId)
                .ValueGeneratedOnAdd()
                .HasColumnName("ProductsSaleID");
            entity.Property(e => e.Description).HasMaxLength(200);
            entity.Property(e => e.LocationId).HasColumnName("LocationID");
            entity.Property(e => e.Price).HasMaxLength(10);
            entity.Property(e => e.ProductId).HasColumnName("ProductID");

            entity.HasOne(d => d.Location).WithMany(p => p.ProductsSales)
                .HasForeignKey(d => d.LocationId)
                .HasConstraintName("FK_ProductsSale_Locations");

            entity.HasOne(d => d.Product).WithMany(p => p.ProductsSales)
                .HasForeignKey(d => d.ProductId)
                .HasConstraintName("FK_ProductsSale_Products");
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.UserId).HasName("PK__Users__1788CCAC2EA99370");

            entity.Property(e => e.UserId).HasColumnName("UserID");
            entity.Property(e => e.Email).HasMaxLength(20);
            entity.Property(e => e.LocationId).HasColumnName("LocationID");
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
