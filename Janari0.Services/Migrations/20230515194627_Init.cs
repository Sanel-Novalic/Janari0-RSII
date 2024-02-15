using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Janari0.Services.Migrations
{
    /// <inheritdoc />
    public partial class Init : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Locations",
                columns: table => new
                {
                    LocationID = table.Column<int>(type: "int", nullable: false).Annotation("SqlServer:Identity", "1, 1"),
                    Latitude = table.Column<decimal>(type: "decimal(18,15)", nullable: false),
                    Longitude = table.Column<decimal>(type: "decimal(18,15)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Location__E7FEA477CE391E6B", x => x.LocationID);
                }
            );

            migrationBuilder.CreateTable(
                name: "Users",
                columns: table => new
                {
                    UserID = table.Column<int>(type: "int", nullable: false).Annotation("SqlServer:Identity", "1, 1"),
                    Username = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    PhoneNumber = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: true),
                    Role = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: true),
                    Email = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    LocationID = table.Column<int>(type: "int", nullable: true),
                    Uid = table.Column<string>(type: "nvarchar(30)", maxLength: 30, nullable: true),
                    PasswordHash = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    PasswordSalt = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Users__1788CCAC2EA99370", x => x.UserID);
                    table.ForeignKey(name: "FK_Users_Locations", column: x => x.LocationID, principalTable: "Locations", principalColumn: "LocationID");
                }
            );

            migrationBuilder.CreateTable(
                name: "Products",
                columns: table => new
                {
                    ProductID = table.Column<int>(type: "int", nullable: false).Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    ExpirationDate = table.Column<DateTime>(type: "datetime", nullable: false),
                    UserID = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Products", x => x.ProductID);
                    table.ForeignKey(name: "FK_Products_Users", column: x => x.UserID, principalTable: "Users", principalColumn: "UserID");
                }
            );

            migrationBuilder.CreateTable(
                name: "Photos",
                columns: table => new
                {
                    PhotoID = table.Column<int>(type: "int", nullable: false).Annotation("SqlServer:Identity", "1, 1"),
                    Link = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    ProductID = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Photos__21B7B5828B3E101A", x => x.PhotoID);
                    table.ForeignKey(
                        name: "FK_Photos_Products",
                        column: x => x.ProductID,
                        principalTable: "Products",
                        principalColumn: "ProductID",
                        onDelete: ReferentialAction.Cascade
                    );
                }
            );

            migrationBuilder.CreateTable(
                name: "ProductsSale",
                columns: table => new
                {
                    ProductSaleID = table.Column<int>(type: "int", nullable: false).Annotation("SqlServer:Identity", "1, 1"),
                    Description = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true),
                    Price = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: true),
                    LocationID = table.Column<int>(type: "int", nullable: false),
                    ProductID = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Products__6723C2D1C83E4825", x => x.ProductSaleID);
                    table.ForeignKey(
                        name: "FK_ProductsSale_Locations",
                        column: x => x.LocationID,
                        principalTable: "Locations",
                        principalColumn: "LocationID",
                        onDelete: ReferentialAction.Cascade
                    );
                    table.ForeignKey(
                        name: "FK_ProductsSale_Products",
                        column: x => x.ProductID,
                        principalTable: "Products",
                        principalColumn: "ProductID",
                        onDelete: ReferentialAction.Cascade
                    );
                }
            );

            migrationBuilder.CreateTable(
                name: "Buyer",
                columns: table => new
                {
                    BuyerID = table.Column<int>(type: "int", nullable: false).Annotation("SqlServer:Identity", "1, 1"),
                    ProductSaleID = table.Column<int>(type: "int", nullable: true),
                    UserID = table.Column<int>(type: "int", nullable: true),
                    Status = table.Column<bool>(type: "bit", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Buyer__4B81C1CA94CF1C1C", x => x.BuyerID);
                    table.ForeignKey(name: "FK_Buyer_ProductsSale", column: x => x.ProductSaleID, principalTable: "ProductsSale", principalColumn: "ProductSaleID");
                    table.ForeignKey(name: "FK_Buyer_Users", column: x => x.UserID, principalTable: "Users", principalColumn: "UserID");
                }
            );

            migrationBuilder.CreateTable(
                name: "Seller",
                columns: table => new
                {
                    SellerID = table.Column<int>(type: "int", nullable: false).Annotation("SqlServer:Identity", "1, 1"),
                    ProductSaleID = table.Column<int>(type: "int", nullable: true),
                    UserID = table.Column<int>(type: "int", nullable: true),
                    Status = table.Column<bool>(type: "bit", nullable: true),
                    PaypalEmail = table.Column<string>(type: "nvarchar(40)", maxLength: 40, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Seller__7FE3DBA17838C381", x => x.SellerID);
                    table.ForeignKey(name: "FK_Seller_ProductsSale", column: x => x.ProductSaleID, principalTable: "ProductsSale", principalColumn: "ProductSaleID");
                    table.ForeignKey(name: "FK_Seller_Users", column: x => x.UserID, principalTable: "Users", principalColumn: "UserID");
                }
            );

            migrationBuilder.CreateTable(
                name: "Orders",
                columns: table => new
                {
                    OrderID = table.Column<int>(type: "int", nullable: false).Annotation("SqlServer:Identity", "1, 1"),
                    OrderNumber = table.Column<string>(type: "nvarchar(40)", maxLength: 40, nullable: true),
                    Date = table.Column<DateTime>(type: "datetime", nullable: true),
                    Status = table.Column<bool>(type: "bit", nullable: true),
                    Canceled = table.Column<bool>(type: "bit", nullable: true),
                    BuyerID = table.Column<int>(type: "int", nullable: true),
                    Price = table.Column<float>(type: "real", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Orders__C3905BAFEE4C1F4C", x => x.OrderID);
                    table.ForeignKey(name: "FK_Orders_Buyer", column: x => x.BuyerID, principalTable: "Buyer", principalColumn: "BuyerID");
                }
            );

            migrationBuilder.CreateTable(
                name: "OrderItems",
                columns: table => new
                {
                    OrderItemID = table.Column<int>(type: "int", nullable: false).Annotation("SqlServer:Identity", "1, 1"),
                    OrderID = table.Column<int>(type: "int", nullable: true),
                    ProductSaleID = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__OrderIte__57ED06A1F935D222", x => x.OrderItemID);
                    table.ForeignKey(name: "FK_OrderItems_Orders", column: x => x.OrderID, principalTable: "Orders", principalColumn: "OrderID");
                    table.ForeignKey(
                        name: "FK_OrderItems_ProductsSale",
                        column: x => x.ProductSaleID,
                        principalTable: "ProductsSale",
                        principalColumn: "ProductSaleID",
                        onDelete: ReferentialAction.Cascade
                    );
                }
            );

            migrationBuilder.CreateTable(
                name: "Output",
                columns: table => new
                {
                    OutputID = table.Column<int>(type: "int", nullable: false).Annotation("SqlServer:Identity", "1, 1"),
                    Date = table.Column<DateTime>(type: "datetime", nullable: true),
                    PaymentMethod = table.Column<string>(type: "nvarchar(40)", maxLength: 40, nullable: true),
                    Concluded = table.Column<bool>(type: "bit", nullable: true),
                    Amount = table.Column<float>(type: "real", nullable: true),
                    ReceiptNumber = table.Column<string>(type: "nvarchar(40)", maxLength: 40, nullable: true),
                    BuyerID = table.Column<int>(type: "int", nullable: true),
                    OrderID = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Output__CE760946B23FB18C", x => x.OutputID);
                    table.ForeignKey(name: "FK_Output_Buyer", column: x => x.BuyerID, principalTable: "Buyer", principalColumn: "BuyerID");
                    table.ForeignKey(name: "FK_Output_Orders", column: x => x.OrderID, principalTable: "Orders", principalColumn: "OrderID");
                }
            );

            migrationBuilder.CreateTable(
                name: "OutputItems",
                columns: table => new
                {
                    OutputItemID = table.Column<int>(type: "int", nullable: false).Annotation("SqlServer:Identity", "1, 1"),
                    OutputID = table.Column<int>(type: "int", nullable: true),
                    ProductSaleID = table.Column<int>(type: "int", nullable: true),
                    Price = table.Column<float>(type: "real", nullable: true),
                    SellerID = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__OutputIt__29975D19564085A6", x => x.OutputItemID);
                    table.ForeignKey(name: "FK_OutputItems_Output", column: x => x.OutputID, principalTable: "Output", principalColumn: "OutputID");
                    table.ForeignKey(name: "FK_OutputItems_ProductsSale", column: x => x.ProductSaleID, principalTable: "ProductsSale", principalColumn: "ProductSaleID");
                    table.ForeignKey(name: "FK_OutputItems_Seller", column: x => x.SellerID, principalTable: "Seller", principalColumn: "SellerID");
                }
            );

            migrationBuilder.CreateIndex(name: "IX_Buyer_ProductSaleID", table: "Buyer", column: "ProductSaleID");

            migrationBuilder.CreateIndex(name: "IX_Buyer_UserID", table: "Buyer", column: "UserID");

            migrationBuilder.CreateIndex(name: "IX_OrderItems_OrderID", table: "OrderItems", column: "OrderID");

            migrationBuilder.CreateIndex(name: "IX_OrderItems_ProductSaleID", table: "OrderItems", column: "ProductSaleID");

            migrationBuilder.CreateIndex(name: "IX_Orders_BuyerID", table: "Orders", column: "BuyerID");

            migrationBuilder.CreateIndex(name: "IX_Output_BuyerID", table: "Output", column: "BuyerID");

            migrationBuilder.CreateIndex(name: "IX_Output_OrderID", table: "Output", column: "OrderID");

            migrationBuilder.CreateIndex(name: "IX_OutputItems_OutputID", table: "OutputItems", column: "OutputID");

            migrationBuilder.CreateIndex(name: "IX_OutputItems_ProductSaleID", table: "OutputItems", column: "ProductSaleID");

            migrationBuilder.CreateIndex(name: "IX_OutputItems_SellerID", table: "OutputItems", column: "SellerID");

            migrationBuilder.CreateIndex(name: "IX_Photos_ProductID", table: "Photos", column: "ProductID");

            migrationBuilder.CreateIndex(name: "IX_Products_UserID", table: "Products", column: "UserID");

            migrationBuilder.CreateIndex(name: "IX_ProductsSale_LocationID", table: "ProductsSale", column: "LocationID");

            migrationBuilder.CreateIndex(name: "IX_ProductsSale_ProductID", table: "ProductsSale", column: "ProductID");

            migrationBuilder.CreateIndex(name: "IX_Seller_ProductSaleID", table: "Seller", column: "ProductSaleID");

            migrationBuilder.CreateIndex(name: "IX_Seller_UserID", table: "Seller", column: "UserID");

            migrationBuilder.CreateIndex(name: "IX_Users_LocationID", table: "Users", column: "LocationID");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(name: "OrderItems");

            migrationBuilder.DropTable(name: "OutputItems");

            migrationBuilder.DropTable(name: "Photos");

            migrationBuilder.DropTable(name: "Output");

            migrationBuilder.DropTable(name: "Seller");

            migrationBuilder.DropTable(name: "Orders");

            migrationBuilder.DropTable(name: "Buyer");

            migrationBuilder.DropTable(name: "ProductsSale");

            migrationBuilder.DropTable(name: "Products");

            migrationBuilder.DropTable(name: "Users");

            migrationBuilder.DropTable(name: "Locations");
        }
    }
}
