import 'package:flutter/material.dart';

import '../model/product.dart';

class ShowProducts extends StatefulWidget {
  static const String routeName = "/show_products";
  final String text;
  final List<Product> products;
  const ShowProducts({super.key, required this.products, required this.text});
  @override
  State<StatefulWidget> createState() => _ShowProducts();
}

class _ShowProducts extends State<ShowProducts> {
  TextEditingController nameController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product list'),
      ),
      body: Column(
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
            itemCount: widget.products.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int i) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                  child: Row(
                children: [
                  Image(
                    image: NetworkImage(widget.products[i].photos.isNotEmpty
                        ? widget.products[i].photos.first.link!
                        : 'https://assets.bonappetit.com/photos/63a390eda38261d1c3bdc555/4:5/w_1920,h_2400,c_limit/best-food-writing-2022-lede.jpg'),
                    fit: BoxFit.fitWidth, // use this
                    height: 60,
                    width: 120,
                  ),
                  Column(
                    children: [
                      Text(widget.products[i].name!),
                      Text(widget.products[i].expirationDate!.toIso8601String())
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {},
                  )
                ],
              )),
            ),
          )
        ],
      ),
    );
  }
}
