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
                    { 2, "mobile", "+387644220370", "User", "mobile@gmail.com", 2, "Klrv5taDRPPqe0cWizfjxAbQW232", null, null },
                    { 3, "mobile2", "+387644220470", "User", "mobile2@gmail.com", 3, "d4jCJjZmfbfYqtXb0jLUaXtdUS63", null, null },
                }
            );
            migrationBuilder.InsertData(
                table: "Products",
                columns: new[] { "ProductID", "Name", "ExpirationDate", "UserID" },
                values: new object[,]
                {
                    { 1, "Argeta", "2023-06-19 00:00:00.000", 2 },
                    { 2, "Datule", "2023-08-19 00:00:00.000", 2 },
                    { 3, "Dva bataka", "2023-06-17 00:00:00.000", 2 },
                    { 4, "Fasirano meso", "2023-07-22 00:00:00.000", 2 },
                    { 5, "Grah", "2023-06-16 00:00:00.000", 2 },
                    { 6, "Jadranska sardina", "2023-06-21 00:00:00.000", 2 },
                    { 7, "Livada sir", "2023-12-19 00:00:00.000", 2 },
                    { 8, "Palenta", "2024-04-19 00:00:00.000", 2 },
                    { 9, "Riza", "2024-04-19 00:00:00.000", 2 },
                    { 10, "Salama", "2023-11-19 00:00:00.000", 2 },
                    { 11, "Šljiva", "2023-11-19 00:00:00.000", 2 },
                    { 12, "Svjeza jaja", "2023-11-19 00:00:00.000", 2 },
                    { 13, "Vitalia", "2023-11-19 00:00:00.000", 2 },
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
                        "https://firebasestorage.googleapis.com/v0/b/janari0-a69b4.appspot.com/o/Argeta.jpg?alt=media&token=93e709ab-ac41-4fae-8f86-f6df1d34b982"
                    },
                    {
                        2,
                        2,
                        "https://firebasestorage.googleapis.com/v0/b/janari0-a69b4.appspot.com/o/Datule.jpg?alt=media&token=d7d58981-3d05-4e46-8366-f7ed2af3c69f"
                    },
                    {
                        3,
                        3,
                        "https://firebasestorage.googleapis.com/v0/b/janari0-a69b4.appspot.com/o/Dva_bataka.jpg?alt=media&token=01258e4b-f8ec-4cee-a2c2-e642861f93ff"
                    },
                    {
                        4,
                        4,
                        "https://firebasestorage.googleapis.com/v0/b/janari0-a69b4.appspot.com/o/Fasirano_meso.jpg?alt=media&token=32657009-3f1a-458c-a5d8-09b89672c70d"
                    },
                    {
                        5,
                        5,
                        "https://firebasestorage.googleapis.com/v0/b/janari0-a69b4.appspot.com/o/Grah.jpg?alt=media&token=dcd915ca-532c-4ac5-ab0a-87c203f20e8a"
                    },
                    {
                        6,
                        6,
                        "https://firebasestorage.googleapis.com/v0/b/janari0-a69b4.appspot.com/o/Jadranska_sardina.jpg?alt=media&token=2e498e23-3db8-4228-b408-e799b7746abd"
                    },
                    {
                        7,
                        7,
                        "https://firebasestorage.googleapis.com/v0/b/janari0-a69b4.appspot.com/o/Livada%2070kb.jpeg?alt=media&token=f8d1174a-d551-41bc-bb95-669897e38de7"
                    },
                    {
                        8,
                        8,
                        "https://firebasestorage.googleapis.com/v0/b/janari0-a69b4.appspot.com/o/Palenta.jpg?alt=media&token=fdb9ac19-47e6-4505-9417-89c6aa21c95f"
                    },
                    {
                        9,
                        9,
                        "https://firebasestorage.googleapis.com/v0/b/janari0-a69b4.appspot.com/o/Riza.jpg?alt=media&token=1c0d8e2a-77d0-42ec-81bd-a02a6c99b23f"
                    },
                    {
                        10,
                        10,
                        "https://firebasestorage.googleapis.com/v0/b/janari0-a69b4.appspot.com/o/Salama.jpg?alt=media&token=43c05c01-6ca2-4e11-872f-86ceac5a6a6c"
                    },
                    {
                        11,
                        11,
                        "https://firebasestorage.googleapis.com/v0/b/janari0-a69b4.appspot.com/o/Sljive.jpg?alt=media&token=9794975a-47e4-4974-9a35-88d06bc1ae2b"
                    },
                    {
                        12,
                        12,
                        "https://firebasestorage.googleapis.com/v0/b/janari0-a69b4.appspot.com/o/Svjeza_JAJA.jpg?alt=media&token=db1700c1-c865-4321-896e-798c0095b134"
                    },
                    {
                        13,
                        13,
                        "https://firebasestorage.googleapis.com/v0/b/janari0-a69b4.appspot.com/o/Vitalia.jpg?alt=media&token=d567b814-bfea-47e6-b5c5-a9ae2cc64a10"
                    },
                }
            );
            migrationBuilder.InsertData(
                table: "ProductsSale",
                columns: new[] { "ProductSaleID", "Description", "Price", "LocationID", "ProductID" },
                values: new object[,]
                {
                    { 1, "Ovu klasišnu argetu sam dobio kao poklon ali ja sam htio lovačku pa ne zelim je", "1", 2, 1 },
                    { 2, "Ramazan dolazi ali ja ne postim", "1.5", 2, 2 },
                    { 3, "Dva bataka koja lijepo izgledaju", "2", 2, 3 },
                    { 4, "Sarma samo takva moze ispasti iz ovoga", "3", 2, 4 },
                    { 5, "Ne znam oprati rizu, nek se neko drugi muci sa njom", "Free", 2, 9 },
                    { 6, "Dodijala mi ova salama, presao sam na kvalitetnije vrste mesa", "Free", 2, 10 },
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
            migrationBuilder.DeleteData(table: "Photos", keyColumn: "PhotoID", keyValue: 11);
            migrationBuilder.DeleteData(table: "Photos", keyColumn: "PhotoID", keyValue: 12);
            migrationBuilder.DeleteData(table: "Photos", keyColumn: "PhotoID", keyValue: 13);

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
            migrationBuilder.DeleteData(table: "Products", keyColumn: "ProductID", keyValue: 11);
            migrationBuilder.DeleteData(table: "Products", keyColumn: "ProductID", keyValue: 12);
            migrationBuilder.DeleteData(table: "Products", keyColumn: "ProductID", keyValue: 13);

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
