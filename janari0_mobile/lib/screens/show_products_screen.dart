import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:janari0/providers/product_provider.dart';

import '../model/product.dart';

class ShowProducts extends StatefulWidget {
  final String text;
  final List<Product> products;
  const ShowProducts({super.key, required this.products, required this.text});
  @override
  State<StatefulWidget> createState() => _ShowProducts();
}

class _ShowProducts extends State<ShowProducts> {
  TextEditingController nameController = TextEditingController();
  DateFormat dateFormat = DateFormat.yMMMMd('en_US');
  ProductProvider productProvider = ProductProvider();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product list'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
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
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.products.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int i) => Padding(
                padding: const EdgeInsets.all(8.0),
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
                    SizedBox(
                      width: width / 15,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            widget.products[i].name!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            dateFormat.format(widget.products[i].expirationDate!),
                            overflow: TextOverflow.clip,
                          )
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => deleteProduct(widget.products[i], i),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  deleteProduct(Product product, int index) async {
    try {
      await productProvider.delete(product.productId!);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Something went wrong while deleting.')));
    }
    setState(() {
      widget.products.removeAt(index);
    });
  }
}
