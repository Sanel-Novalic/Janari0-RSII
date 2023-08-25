using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Janari0.Services.Migrations
{
    /// <inheritdoc />
    public partial class Jengo : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Buyer_ProductsSale",
                table: "Buyer");

            migrationBuilder.DropForeignKey(
                name: "FK_OrderItems_Orders",
                table: "OrderItems");

            migrationBuilder.DropForeignKey(
                name: "FK_OrderItems_ProductsSale",
                table: "OrderItems");

            migrationBuilder.DropForeignKey(
                name: "FK_Orders_Buyer",
                table: "Orders");

            migrationBuilder.DropForeignKey(
                name: "FK_Output_Buyer",
                table: "Output");

            migrationBuilder.DropForeignKey(
                name: "FK_Output_Orders",
                table: "Output");

            migrationBuilder.DropForeignKey(
                name: "FK_OutputItems_Output",
                table: "OutputItems");

            migrationBuilder.DropForeignKey(
                name: "FK_OutputItems_ProductsSale",
                table: "OutputItems");

            migrationBuilder.DropForeignKey(
                name: "FK_Products_Users",
                table: "Products");

            migrationBuilder.DropForeignKey(
                name: "FK_ProductsSale_Locations",
                table: "ProductsSale");

            migrationBuilder.DropForeignKey(
                name: "FK_Seller_ProductsSale",
                table: "Seller");

            migrationBuilder.DropForeignKey(
                name: "FK_Seller_Users",
                table: "Seller");

            migrationBuilder.DropForeignKey(
                name: "FK_Users_Locations",
                table: "Users");

            migrationBuilder.DropIndex(
                name: "IX_Seller_ProductSaleID",
                table: "Seller");

            migrationBuilder.DropIndex(
                name: "IX_Seller_UserID",
                table: "Seller");

            migrationBuilder.DropIndex(
                name: "IX_OutputItems_ProductSaleID",
                table: "OutputItems");

            migrationBuilder.DropIndex(
                name: "IX_Output_BuyerID",
                table: "Output");

            migrationBuilder.DropIndex(
                name: "IX_Output_OrderID",
                table: "Output");

            migrationBuilder.DropIndex(
                name: "IX_OrderItems_OrderID",
                table: "OrderItems");

            migrationBuilder.DropIndex(
                name: "IX_OrderItems_ProductSaleID",
                table: "OrderItems");

            migrationBuilder.AlterColumn<string>(
                name: "Email",
                table: "Users",
                type: "nvarchar(30)",
                maxLength: 30,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(20)",
                oldMaxLength: 20);

            migrationBuilder.AlterColumn<int>(
                name: "LocationID",
                table: "ProductsSale",
                type: "int",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.AddForeignKey(
                name: "FK_Buyer_ProductsSale",
                table: "Buyer",
                column: "ProductSaleID",
                principalTable: "ProductsSale",
                principalColumn: "ProductSaleID",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Orders_Buyer",
                table: "Orders",
                column: "BuyerID",
                principalTable: "Buyer",
                principalColumn: "BuyerID",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_OutputItems_Output",
                table: "OutputItems",
                column: "OutputID",
                principalTable: "Output",
                principalColumn: "OutputID",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Products_Users",
                table: "Products",
                column: "UserID",
                principalTable: "Users",
                principalColumn: "UserID",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_ProductsSale_Locations",
                table: "ProductsSale",
                column: "LocationID",
                principalTable: "Locations",
                principalColumn: "LocationID");

            migrationBuilder.AddForeignKey(
                name: "FK_Users_Locations",
                table: "Users",
                column: "LocationID",
                principalTable: "Locations",
                principalColumn: "LocationID",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Buyer_ProductsSale",
                table: "Buyer");

            migrationBuilder.DropForeignKey(
                name: "FK_Orders_Buyer",
                table: "Orders");

            migrationBuilder.DropForeignKey(
                name: "FK_OutputItems_Output",
                table: "OutputItems");

            migrationBuilder.DropForeignKey(
                name: "FK_Products_Users",
                table: "Products");

            migrationBuilder.DropForeignKey(
                name: "FK_ProductsSale_Locations",
                table: "ProductsSale");

            migrationBuilder.DropForeignKey(
                name: "FK_Users_Locations",
                table: "Users");

            migrationBuilder.AlterColumn<string>(
                name: "Email",
                table: "Users",
                type: "nvarchar(20)",
                maxLength: 20,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(30)",
                oldMaxLength: 30);

            migrationBuilder.AlterColumn<int>(
                name: "LocationID",
                table: "ProductsSale",
                type: "int",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "int",
                oldNullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Seller_ProductSaleID",
                table: "Seller",
                column: "ProductSaleID");

            migrationBuilder.CreateIndex(
                name: "IX_Seller_UserID",
                table: "Seller",
                column: "UserID");

            migrationBuilder.CreateIndex(
                name: "IX_OutputItems_ProductSaleID",
                table: "OutputItems",
                column: "ProductSaleID");

            migrationBuilder.CreateIndex(
                name: "IX_Output_BuyerID",
                table: "Output",
                column: "BuyerID");

            migrationBuilder.CreateIndex(
                name: "IX_Output_OrderID",
                table: "Output",
                column: "OrderID");

            migrationBuilder.CreateIndex(
                name: "IX_OrderItems_OrderID",
                table: "OrderItems",
                column: "OrderID");

            migrationBuilder.CreateIndex(
                name: "IX_OrderItems_ProductSaleID",
                table: "OrderItems",
                column: "ProductSaleID");

            migrationBuilder.AddForeignKey(
                name: "FK_Buyer_ProductsSale",
                table: "Buyer",
                column: "ProductSaleID",
                principalTable: "ProductsSale",
                principalColumn: "ProductSaleID");

            migrationBuilder.AddForeignKey(
                name: "FK_OrderItems_Orders",
                table: "OrderItems",
                column: "OrderID",
                principalTable: "Orders",
                principalColumn: "OrderID");

            migrationBuilder.AddForeignKey(
                name: "FK_OrderItems_ProductsSale",
                table: "OrderItems",
                column: "ProductSaleID",
                principalTable: "ProductsSale",
                principalColumn: "ProductSaleID",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Orders_Buyer",
                table: "Orders",
                column: "BuyerID",
                principalTable: "Buyer",
                principalColumn: "BuyerID");

            migrationBuilder.AddForeignKey(
                name: "FK_Output_Buyer",
                table: "Output",
                column: "BuyerID",
                principalTable: "Buyer",
                principalColumn: "BuyerID");

            migrationBuilder.AddForeignKey(
                name: "FK_Output_Orders",
                table: "Output",
                column: "OrderID",
                principalTable: "Orders",
                principalColumn: "OrderID");

            migrationBuilder.AddForeignKey(
                name: "FK_OutputItems_Output",
                table: "OutputItems",
                column: "OutputID",
                principalTable: "Output",
                principalColumn: "OutputID");

            migrationBuilder.AddForeignKey(
                name: "FK_OutputItems_ProductsSale",
                table: "OutputItems",
                column: "ProductSaleID",
                principalTable: "ProductsSale",
                principalColumn: "ProductSaleID");

            migrationBuilder.AddForeignKey(
                name: "FK_Products_Users",
                table: "Products",
                column: "UserID",
                principalTable: "Users",
                principalColumn: "UserID");

            migrationBuilder.AddForeignKey(
                name: "FK_ProductsSale_Locations",
                table: "ProductsSale",
                column: "LocationID",
                principalTable: "Locations",
                principalColumn: "LocationID",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Seller_ProductsSale",
                table: "Seller",
                column: "ProductSaleID",
                principalTable: "ProductsSale",
                principalColumn: "ProductSaleID");

            migrationBuilder.AddForeignKey(
                name: "FK_Seller_Users",
                table: "Seller",
                column: "UserID",
                principalTable: "Users",
                principalColumn: "UserID");

            migrationBuilder.AddForeignKey(
                name: "FK_Users_Locations",
                table: "Users",
                column: "LocationID",
                principalTable: "Locations",
                principalColumn: "LocationID");
        }
    }
}
