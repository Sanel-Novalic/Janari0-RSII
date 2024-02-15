using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Janari0.Services.Migrations
{
    /// <inheritdoc />
    public partial class dataSeed : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "Locations",
                columns: new[] { "LocationID", "Latitude", "Longitude" },
                values: new object[,]
                {
                    { 1, 43.348026200000000, 17.802498200000000 },
                    { 2, 43.348026200000000, 17.802498200000000 },
                    { 3, 43.348026200000000, 17.802498200000000 },
                }
            );
            migrationBuilder.InsertData(
                table: "Users",
                columns: new[] { "UserID", "Username", "PhoneNumber", "Role", "Email", "LocationID", "Uid", "PasswordHash", "PasswordSalt" },
                values: new object[,]
                {
                    { 1, "admin", "+387644220270", "Admin", "admin@gmail.com", 1, null, "NEEphxx+90yIpTB9+oQgr+uqkwyswcKetdlnWaNPAu8=", "p9oxnS3jScFdY1Xoml8vhQ==" },
                    { 2, "mobile", "+387644220370", "User", "mobile@gmail.com", 2, "w6JtEuE2uDRKG2wVgFDJ409Mkx12", null, null },
                    { 3, "mobile2", "+387644220470", "User", "mobile2@gmail.com", 3, "wfWRlB2A0SWXztYeM1SbZvYpYuQ2", null, null },
                }
            );
            migrationBuilder.InsertData(
                table: "Products",
                columns: new[] { "ProductID", "Name", "ExpirationDate", "UserID" },
                values: new object[,]
                {
                    { 1, "Ketchup", "2023-06-19 00:00:00.000", 2 },
                    { 2, "Truffles", "2023-08-19 00:00:00.000", 2 },
                    { 3, "Čokolino protein", "2023-06-17 00:00:00.000", 2 },
                    { 4, "Focus Mango", "2023-07-22 00:00:00.000", 2 },
                    { 5, "Senf", "2023-06-16 00:00:00.000", 2 },
                    { 6, "Zottis", "2023-06-21 00:00:00.000", 2 },
                    { 7, "Pečena piletina začin", "2023-12-19 00:00:00.000", 2 },
                    { 8, "Vegeta", "2024-04-19 00:00:00.000", 2 },
                    { 9, "Kamilica", "2024-04-19 00:00:00.000", 2 },
                    { 10, "Špagete", "2023-11-19 00:00:00.000", 2 },
                }
            );
            migrationBuilder.InsertData(
                table: "Photos",
                columns: new[] { "PhotoID", "ProductID", "Link" },
                values: new object[,]
                {
                    {
                        1,
                        1,
                        "https://firebasestorage.googleapis.com/v0/b/janari0-b4e82.appspot.com/o/images%2F4rYusPYk5PYmSdN8t1niVNnQIk83%2F1686761623955_800?alt=media&token=7dfe3431-501a-491b-99ea-925788b42cd7"
                    },
                    {
                        2,
                        2,
                        "https://firebasestorage.googleapis.com/v0/b/janari0-b4e82.appspot.com/o/images%2F4rYusPYk5PYmSdN8t1niVNnQIk83%2F1686763406250_800?alt=media&token=fc2971f0-b6ef-4c8a-a850-9dc5fb2b0370"
                    },
                    {
                        3,
                        3,
                        "https://firebasestorage.googleapis.com/v0/b/janari0-b4e82.appspot.com/o/images%2F4rYusPYk5PYmSdN8t1niVNnQIk83%2F1686763483386_800?alt=media&token=5969c315-e0ad-4801-9eca-cbd5f0f00bc6"
                    },
                    {
                        4,
                        4,
                        "https://firebasestorage.googleapis.com/v0/b/janari0-b4e82.appspot.com/o/images%2F4rYusPYk5PYmSdN8t1niVNnQIk83%2F1686763549194_800?alt=media&token=382be1f7-fa34-405e-a759-ed15e1bebf5b"
                    },
                    {
                        5,
                        5,
                        "https://firebasestorage.googleapis.com/v0/b/janari0-b4e82.appspot.com/o/images%2F4rYusPYk5PYmSdN8t1niVNnQIk83%2F1686763709894_800?alt=media&token=589c594d-f80d-4264-91d9-c92ff4bf61ca"
                    },
                    {
                        6,
                        6,
                        "https://firebasestorage.googleapis.com/v0/b/janari0-b4e82.appspot.com/o/images%2F4rYusPYk5PYmSdN8t1niVNnQIk83%2F1686763756454_800?alt=media&token=1f924469-59e5-4aeb-bb28-de07dce30a0a"
                    },
                    {
                        7,
                        7,
                        "https://firebasestorage.googleapis.com/v0/b/janari0-b4e82.appspot.com/o/images%2F4rYusPYk5PYmSdN8t1niVNnQIk83%2F1686763850530_800?alt=media&token=93def85b-cdb0-45ff-8e6f-353a19058901"
                    },
                    {
                        8,
                        8,
                        "https://firebasestorage.googleapis.com/v0/b/janari0-b4e82.appspot.com/o/images%2F4rYusPYk5PYmSdN8t1niVNnQIk83%2F1686763983753_800?alt=media&token=785e38d7-1f29-4f57-9436-f746367d0e34"
                    },
                    {
                        9,
                        9,
                        "https://firebasestorage.googleapis.com/v0/b/janari0-b4e82.appspot.com/o/images%2F4rYusPYk5PYmSdN8t1niVNnQIk83%2F1686764015046_800?alt=media&token=f7964c14-7084-4750-8337-352014e39574"
                    },
                    {
                        10,
                        10,
                        "https://firebasestorage.googleapis.com/v0/b/janari0-b4e82.appspot.com/o/images%2F4rYusPYk5PYmSdN8t1niVNnQIk83%2F1686764057541_800?alt=media&token=68983511-7cd0-4a77-b5c3-39feb1a3c796"
                    },
                }
            );
            migrationBuilder.InsertData(
                table: "ProductsSale",
                columns: new[] { "ProductSaleID", "Description", "Price", "LocationID", "ProductID" },
                values: new object[,]
                {
                    { 1, "Najbolji kečap ikad", "1", 2, 1 },
                    { 2, "Luksuzan ukus", "1.5", 2, 2 },
                    { 3, "Odličan za teretane a i za mršanje", "4", 2, 3 },
                    { 4, "Underrated piće, odličan ukus", "0.5", 2, 4 },
                    { 5, "Obična kamilica", "Free", 2, 9 },
                    { 6, "Špagete kupljene u italiji", "Free", 2, 10 },
                }
            );
            migrationBuilder.InsertData(
                table: "Buyer",
                columns: new[] { "BuyerID", "ProductSaleID", "UserID", "Status" },
                values: new object[,]
                {
                    { 1, 1, 3, true },
                    { 2, 2, 3, true },
                }
            );
            migrationBuilder.InsertData(
                table: "Orders",
                columns: new[] { "OrderID", "OrderNumber", "Date", "Status", "Canceled", "BuyerID", "Price" },
                values: new object[,]
                {
                    { 1, "1", DateTime.Parse("2023-05-06 00:06:40.300"), true, false, 1, 1 },
                    { 2, "2", DateTime.Parse("2023-06-06 00:06:40.300"), true, false, 2, 1.5 },
                }
            );
            migrationBuilder.InsertData(
                table: "OrderItems",
                columns: new[] { "OrderItemID", "OrderID", "ProductSaleID" },
                values: new object[,]
                {
                    { 1, 1, 1 },
                    { 2, 2, 2 },
                }
            );
            migrationBuilder.InsertData(
                table: "Output",
                columns: new[] { "OutputID", "Date", "PaymentMethod", "Concluded", "Amount", "ReceiptNumber", "BuyerID", "OrderID" },
                values: new object[,]
                {
                    { 1, DateTime.Parse("2023-05-06 00:06:40.300"), "Paypal", true, 1, "RS1", 1, 1 },
                    { 2, DateTime.Parse("2023-06-06 00:06:40.300"), "Paypal", true, 1.5, "RS2", 2, 2 },
                }
            );
            migrationBuilder.InsertData(
                table: "Seller",
                columns: new[] { "SellerID", "ProductSaleID", "UserID", "Status", "PaypalEmail" },
                values: new object[,]
                {
                    { 1, 1, 2, true, "mobile@gmail.com" },
                    { 2, 2, 2, true, "mobile@gmail.com" },
                }
            );
            migrationBuilder.InsertData(
                table: "OutputItems",
                columns: new[] { "OutputItemID", "OutputID", "ProductSaleID", "Price", "SellerID" },
                values: new object[,]
                {
                    { 1, 1, 1, 1, 1 },
                    { 2, 2, 2, 1.5, 2 },
                }
            );
            /*,*/
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(table: "Photos", keyColumn: "PhotoID", keyValue: 1);
            migrationBuilder.DeleteData(table: "Photos", keyColumn: "PhotoID", keyValue: 2);
            migrationBuilder.DeleteData(table: "Photos", keyColumn: "PhotoID", keyValue: 3);
            migrationBuilder.DeleteData(table: "Photos", keyColumn: "PhotoID", keyValue: 4);
            migrationBuilder.DeleteData(table: "Photos", keyColumn: "PhotoID", keyValue: 5);
            migrationBuilder.DeleteData(table: "Photos", keyColumn: "PhotoID", keyValue: 6);
            migrationBuilder.DeleteData(table: "Photos", keyColumn: "PhotoID", keyValue: 7);
            migrationBuilder.DeleteData(table: "Photos", keyColumn: "PhotoID", keyValue: 8);
            migrationBuilder.DeleteData(table: "Photos", keyColumn: "PhotoID", keyValue: 9);
            migrationBuilder.DeleteData(table: "Photos", keyColumn: "PhotoID", keyValue: 10);

            migrationBuilder.DeleteData(table: "Locations", keyColumn: "LocationID", keyValue: 1);
            migrationBuilder.DeleteData(table: "Locations", keyColumn: "LocationID", keyValue: 2);
            migrationBuilder.DeleteData(table: "Locations", keyColumn: "LocationID", keyValue: 3);

            migrationBuilder.DeleteData(table: "Users", keyColumn: "UserID", keyValue: 1);
            migrationBuilder.DeleteData(table: "Users", keyColumn: "UserID", keyValue: 2);
            migrationBuilder.DeleteData(table: "Users", keyColumn: "UserID", keyValue: 3);

            migrationBuilder.DeleteData(table: "Products", keyColumn: "ProductID", keyValue: 1);
            migrationBuilder.DeleteData(table: "Products", keyColumn: "ProductID", keyValue: 2);
            migrationBuilder.DeleteData(table: "Products", keyColumn: "ProductID", keyValue: 3);
            migrationBuilder.DeleteData(table: "Products", keyColumn: "ProductID", keyValue: 4);
            migrationBuilder.DeleteData(table: "Products", keyColumn: "ProductID", keyValue: 5);
            migrationBuilder.DeleteData(table: "Products", keyColumn: "ProductID", keyValue: 6);
            migrationBuilder.DeleteData(table: "Products", keyColumn: "ProductID", keyValue: 7);
            migrationBuilder.DeleteData(table: "Products", keyColumn: "ProductID", keyValue: 8);
            migrationBuilder.DeleteData(table: "Products", keyColumn: "ProductID", keyValue: 9);
            migrationBuilder.DeleteData(table: "Products", keyColumn: "ProductID", keyValue: 10);

            migrationBuilder.DeleteData(table: "ProductsSale", keyColumn: "ProductSaleID", keyValue: 1);
            migrationBuilder.DeleteData(table: "ProductsSale", keyColumn: "ProductSaleID", keyValue: 2);
            migrationBuilder.DeleteData(table: "ProductsSale", keyColumn: "ProductSaleID", keyValue: 3);
            migrationBuilder.DeleteData(table: "ProductsSale", keyColumn: "ProductSaleID", keyValue: 4);
            migrationBuilder.DeleteData(table: "ProductsSale", keyColumn: "ProductSaleID", keyValue: 5);
            migrationBuilder.DeleteData(table: "ProductsSale", keyColumn: "ProductSaleID", keyValue: 6);

            migrationBuilder.DeleteData(table: "Buyer", keyColumn: "BuyerID", keyValue: 1);
            migrationBuilder.DeleteData(table: "Buyer", keyColumn: "BuyerID", keyValue: 2);

            migrationBuilder.DeleteData(table: "Orders", keyColumn: "OrderID", keyValue: 1);
            migrationBuilder.DeleteData(table: "Orders", keyColumn: "OrderID", keyValue: 2);

            migrationBuilder.DeleteData(table: "OrderItems", keyColumn: "OrderItemID", keyValue: 1);
            migrationBuilder.DeleteData(table: "OrderItems", keyColumn: "OrderItemID", keyValue: 2);

            migrationBuilder.DeleteData(table: "Output", keyColumn: "OutputID", keyValue: 1);
            migrationBuilder.DeleteData(table: "Output", keyColumn: "OutputID", keyValue: 2);

            migrationBuilder.DeleteData(table: "Seller", keyColumn: "SellerID", keyValue: 1);
            migrationBuilder.DeleteData(table: "Seller", keyColumn: "SellerID", keyValue: 2);

            migrationBuilder.DeleteData(table: "OutputItems", keyColumn: "OutputItemID", keyValue: 1);
            migrationBuilder.DeleteData(table: "OutputItems", keyColumn: "OutputItemID", keyValue: 2);
        }
    }
}
