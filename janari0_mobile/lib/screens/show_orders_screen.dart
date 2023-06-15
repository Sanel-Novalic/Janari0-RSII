import 'package:flutter/material.dart';

import '../model/order.dart';
import '../model/user.dart';
import '../providers/order_provider.dart';

class ShowOrders extends StatefulWidget {
  final String text;
  final User user;
  const ShowOrders({super.key, required this.text, required this.user});
  @override
  State<StatefulWidget> createState() => _ShowOrders();
}

class _ShowOrders extends State<ShowOrders> {
  TextEditingController nameController = TextEditingController();
  OrderProvider orderProvider = OrderProvider();
  late List<Order> orders;
  late Future<List<Order>> myFuture;
  @override
  void initState() {
    super.initState();
    myFuture = loadData();
  }

  Future<List<Order>> loadData() async {
    var searchObject = {"userId": widget.user.userId};
    var orderData = await orderProvider.get(searchObject);
    setState(() {
      orders = orderData;
    });
    return orders;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product list'),
      ),
      body: FutureBuilder(
        future: myFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          return Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: double.infinity,
                  child: Text(
                    widget.text,
                    textAlign: TextAlign.center,
                  )),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                itemCount: orders.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int i) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(
                        width: 12,
                      ),
                      Column(
                        children: [
                          const Text("Order number: "),
                          Text(orders[i].orderNumber!),
                        ],
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Column(
                        children: [
                          const Text("Status: "),
                          Text(orders[i].status == true
                              ? "Finished"
                              : "In progress")
                        ],
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Column(
                        children: [
                          const Text("Price: "),
                          Text("${orders[i].price}\$")
                        ],
                      ),
                      Column(
                        children: [
                          const Text("Canceled: "),
                          Text(orders[i].canceled.toString())
                        ],
                      ),
                    ],
                  )),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
