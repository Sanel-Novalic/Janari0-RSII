using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace Janari0.Services.Database;

public partial class Janari0Context : DbContext
{
    public Janari0Context()
    {
    }

    public Janari0Context(DbContextOptions<Janari0Context> options)
        : base(options)
    {
    }

    public virtual DbSet<Location> Locations { get; set; }

    public virtual DbSet<Photo> Photos { get; set; }

    public virtual DbSet<Product> Products { get; set; }

    public virtual DbSet<ProductsSale> ProductsSales { get; set; }

    public virtual DbSet<User> Users { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Data Source=.;Initial Catalog=Janari0;Integrated Security=SSPI;TrustServerCertificate=True");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Location>(entity =>
        {
            entity.Property(e => e.LocationId)
                .ValueGeneratedNever()
                .HasColumnName("LocationID");
            entity.Property(e => e.Geohash)
                .HasMaxLength(10)
                .IsFixedLength();
            entity.Property(e => e.Latitude).HasColumnType("decimal(18, 15)");
            entity.Property(e => e.Longitude).HasColumnType("decimal(18, 15)");
        });

        modelBuilder.Entity<Photo>(entity =>
        {
            entity.Property(e => e.PhotoId)
                .ValueGeneratedNever()
                .HasColumnName("PhotoID");
            entity.Property(e => e.Link).HasMaxLength(200);
            entity.Property(e => e.PhotosId).HasColumnName("PhotosID");
        });

        modelBuilder.Entity<Product>(entity =>
        {
            entity.Property(e => e.ProductId)
                .ValueGeneratedOnAdd()
                .HasColumnName("ProductID");
            entity.Property(e => e.ExpirationDate).HasColumnType("datetime");
            entity.Property(e => e.Name).HasMaxLength(50);
            entity.Property(e => e.PhotosId).HasColumnName("PhotosID");
        });

        modelBuilder.Entity<ProductsSale>(entity =>
        {
            entity.HasKey(e => e.ProductDonateId).HasName("PK_ProductsDonate");

            entity.ToTable("ProductsSale");

            entity.Property(e => e.ProductDonateId)
                .ValueGeneratedNever()
                .HasColumnName("ProductDonateID");
            entity.Property(e => e.Description).HasMaxLength(200);
            entity.Property(e => e.LocationId).HasColumnName("LocationID");
            entity.Property(e => e.PhoneNumber).HasMaxLength(20);
            entity.Property(e => e.Price).HasMaxLength(10);
            entity.Property(e => e.ProductId).HasColumnName("ProductID");
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.UserId).HasName("PK_User");

            entity.Property(e => e.UserId)
                .ValueGeneratedOnAdd()
                .HasColumnName("UserID");
            entity.Property(e => e.Geohash)
                .HasMaxLength(10)
                .IsFixedLength();
            entity.Property(e => e.PhoneNumber).HasMaxLength(20);
            entity.Property(e => e.Role).HasMaxLength(10);
            entity.Property(e => e.Username).HasMaxLength(20);
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
