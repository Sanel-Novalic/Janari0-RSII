import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:janari0/model/order.dart';
import 'package:janari0/model/output.dart';
import 'package:janari0/model/product.dart';
import 'package:janari0/model/product_sale.dart';
import 'package:janari0/model/user.dart';
import 'package:janari0/providers/order_provider.dart';
import 'package:janari0/providers/output_provider.dart';
import 'package:janari0/providers/product_provider.dart';
import 'package:janari0/providers/product_sale_provider.dart';
import 'package:janari0/providers/user_provider.dart';
import 'package:janari0_admin/controllers/menu_app_controller.dart';
import 'package:janari0_admin/screens/create_row.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import 'package:get/get.dart';

import '../edit_row.dart';

enum TABLE { users, products, productsSale, orders, output }

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<StatefulWidget> createState() => _DashboardScreen();
}

UserProvider userProvider = UserProvider();
ProductProvider productProvider = ProductProvider();
ProductSaleProvider productSaleProvider = ProductSaleProvider();
OrderProvider orderProvider = OrderProvider();
OutputProvider outputProvider = OutputProvider();
List<User> users = [];
List<Product> products = [];
List<ProductSale> productsSale = [];
List<Order> orders = [];
List<Output> outputs = [];

class _DashboardScreen extends State<DashboardScreen> {
  List<Widget> widgets = [];
  final StreamController<List<User>> _dataController =
      StreamController<List<User>>();
  Stream<List<User>> get dataStream => _dataController.stream;
  @override
  void initState() {
    super.initState();
    _dataController.addStream(loadData());
  }

  Stream<List<User>> loadData() async* {
    users = await userProvider.get();
    products = await productProvider.get();
    productsSale = await productSaleProvider.get();
    orders = await orderProvider.get();
    outputs = await outputProvider.get();
    createWidgets();
    yield users;
  }

  @override
  Widget build(BuildContext context) {
    var drawer = Provider.of<MenuAppController>(context, listen: true);
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: StreamBuilder(
        stream: dataStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: defaultPadding),
                  if (widgets.isNotEmpty) widgets[drawer.getCurrentDrawer],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget table(
      String headline, Text col1, Text col2, Text col3, DataTableSource source,
      {Text? col4}) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                headline,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Spacer(),
              InkWell(
                onTap: () => {createRow(headline)},
                child: const Padding(
                  padding: EdgeInsets.only(right: 24),
                  child: Text(
                    'Create a row',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: PaginatedDataTable(
                columnSpacing: defaultPadding,
                rowsPerPage: 10,
                columns: [
                  DataColumn(
                    label: col1,
                  ),
                  DataColumn(
                    label: col2,
                  ),
                  DataColumn(
                    label: col3,
                  ),
                  if (col4 != null)
                    DataColumn(
                      label: col4,
                    ),
                  const DataColumn(
                    label: Text("Actions"),
                  ),
                ],
                source: source),
          ),
        ],
      ),
    );
  }

  Future<void> _refreshData() async {
    _dataController.addStream(loadData());
  }

  void update({String? message}) {
    if (message != '' && message != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
    _refreshData();
  }

  void createWidgets() {
    widgets = []; // Clear existing widgets

    widgets.add(table("Users", const Text("UserID"), const Text("Username"),
        const Text("Email"), UsersData(update: update)));

    widgets.add(table("Products", const Text("ProductID"), const Text("Name"),
        const Text("Expiration Date"), ProductsData(update: update),
        col4: const Text("Photos")));

    widgets.add(table(
        "ProductsSale",
        const Text("ProductSaleID"),
        const Text("Price"),
        const Text("Description"),
        ProductsSaleData(update: update)));

    widgets.add(table("Orders", const Text("OrderID"), const Text("Price"),
        const Text("Status"), OrderData(update: update)));

    widgets.add(table("Outputs", const Text("OutputID"), const Text("Amount"),
        const Text("Concluded"), OutputData(update: update)));
  }

  createRow(headline) async {
    var row = TABLE.users;
    switch (headline) {
      case "Products":
        row = TABLE.products;
        break;
      case "ProductsSale":
        row = TABLE.productsSale;
        break;
      case "Orders":
        row = TABLE.orders;
        break;
      case "Outputs":
        row = TABLE.output;
        break;
    }
    var result = await Get.to(() => CreateRow(row: row));
    if (result == 'Created') {
      update(message: "Successfully created a row");
    }
  }
}

Widget actions(dynamic row, Function({String? message}) update) {
  return Row(
    children: [
      InkWell(
        onTap: () => {
          Get.to(() => EditRow(
                    row: row,
                  ))!
              .then((value) => {update(message: value)})
        },
        child: const Text(
          'Edit',
          style: TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
      const Text(' | '),
      InkWell(
        onTap: () => {deleteRow(row, update)},
        child: const Text(
          'Delete',
          style: TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    ],
  );
}

deleteRow(row, Function({String message}) update) async {
  try {
    if (row is User) {
      await userProvider.delete(row.userId);
      users.remove(row);
    } else if (row is Product) {
      await productProvider.delete(row.productId!);
      products.remove(row);
    } else if (row is ProductSale) {
      await productSaleProvider.delete(row.productSaleId!);
      productsSale.remove(row);
    } else if (row is Order) {
      await orderProvider.delete(row.orderId!);
      orders.remove(row);
    } else if (row is Output) {
      await outputProvider.delete(row.outputId!);
      outputs.remove(row);
    }
    update(message: 'Successfully deleted the row');
  } catch (e) {
    update(message: 'Something went wrong while deleting row');
  }
}

class UsersData extends DataTableSource {
  final Function({String? message}) update;

  UsersData({required this.update});
  @override
  DataRow? getRow(int index) {
    final user = users[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(user.userId.toString())),
      DataCell(Text(user.username)),
      DataCell(Text(user.email)),
      DataCell(actions(user, update))
    ]);
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => users.length;
  @override
  int get selectedRowCount => 0;
}

class ProductsData extends DataTableSource {
  final Function({String? message}) update;

  ProductsData({required this.update});
  @override
  DataRow? getRow(int index) {
    final product = products[index];
    String formattedDate =
        DateFormat('yyyy-MM-dd').format(product.expirationDate!);
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(product.productId.toString())),
      DataCell(Text(product.name!)),
      DataCell(Text(formattedDate)),
      DataCell(carouselView(product.photos.map((p) => p.link ?? "").toList())),
      DataCell(actions(product, update))
    ]);
  }

  Widget carouselView(List<String> imageUrls) {
    if (imageUrls.isEmpty) {
      return Text("No images");
    }
    return Container(
      height: 100,
      width: 100, // Specify a fixed height appropriate for your layout
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 2.0,
          enlargeCenterPage: true,
          viewportFraction: 0.8,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
        ),
        items: imageUrls.map((url) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(color: Colors.amber),
                child: Image.network(url, fit: BoxFit.cover),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => products.length;
  @override
  int get selectedRowCount => 0;
}

class ProductsSaleData extends DataTableSource {
  final Function({String? message}) update;

  ProductsSaleData({required this.update});
  @override
  DataRow? getRow(int index) {
    final productSale = productsSale[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(productSale.productSaleId.toString())),
      DataCell(Text(productSale.price)),
      DataCell(Text(productSale.description!)),
      DataCell(actions(productSale, update))
    ]);
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => productsSale.length;
  @override
  int get selectedRowCount => 0;
}

class OrderData extends DataTableSource {
  final Function({String? message}) update;

  OrderData({required this.update});
  @override
  DataRow? getRow(int index) {
    final order = orders[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(order.orderId.toString())),
      DataCell(Text(order.date!)),
      DataCell(Text(order.status.toString())),
      DataCell(actions(order, update))
    ]);
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => orders.length;
  @override
  int get selectedRowCount => 0;
}

class OutputData extends DataTableSource {
  final Function({String? message}) update;

  OutputData({required this.update});
  @override
  DataRow? getRow(int index) {
    final output = outputs[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(output.outputId.toString())),
      DataCell(Text(output.amount.toString())),
      DataCell(Text(output.concluded.toString())),
      DataCell(actions(output, update))
    ]);
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => outputs.length;
  @override
  int get selectedRowCount => 0;
}
