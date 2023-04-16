import 'package:flutter/material.dart';
import '../model/product_sale.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../providers/product_provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String routeName = "/product_details";
  final ProductSale productSale;
  const ProductDetailsScreen({super.key, required this.productSale});
  @override
  State<StatefulWidget> createState() => _ProductDetailsScreen();
}

class _ProductDetailsScreen extends State<ProductDetailsScreen> {
  ProductProvider productProvider = ProductProvider();
  CarouselController carouselController = CarouselController();
  List<String> photoLinks = [];
  int _current = 0;
  @override
  void initState() {
    super.initState();
    photoLinks.addAll(widget.productSale.product!.photos.map((e) => e.link!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product details'),
      ),
      body: Column(
        children: [
          CarouselSlider(
            carouselController: carouselController,
            options: CarouselOptions(
                enableInfiniteScroll: false,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
            items: widget.productSale.product!.photos
                .map((item) => Center(
                    child: Image.network(
                        item.link ??
                            "https://assets.bonappetit.com/photos/63a390eda38261d1c3bdc555/4:5/w_1920,h_2400,c_limit/best-food-writing-2022-lede.jpg",
                        fit: BoxFit.cover,
                        width: 1000)))
                .toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: photoLinks.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => carouselController.animateToPage(entry.key),
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black)
                          .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                ),
              );
            }).toList(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 5),
            child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(widget.productSale.product!.name!,
                    style: const TextStyle(color: Colors.grey))),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 10),
            child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  widget.productSale.price,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 10),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(widget.productSale.description ?? "",
                  style: const TextStyle(color: Colors.grey)),
            ),
          ),
        ],
      ),
    );
  }
}
