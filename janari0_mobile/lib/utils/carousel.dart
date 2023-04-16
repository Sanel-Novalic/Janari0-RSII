import 'package:flutter/material.dart';
import 'package:janari0_mobile/screens/product_details_screen.dart';

import '../model/product_sale.dart';

class CustomCarousel extends StatelessWidget {
  final String text;
  final List<ProductSale> productsSale;
  const CustomCarousel(
      {super.key, required this.text, required this.productsSale});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5.0, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(child: Text(text)),
              Padding(
                  padding: const EdgeInsets.only(right: 2.0),
                  child: InkWell(
                      onTap: () => debugPrint("AYY"),
                      child: const Text('See all >')))
            ],
          ),
        ),
        Container(
            height: 180,
            width: double.infinity,
            padding: const EdgeInsets.only(left: 5),
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, _) => const SizedBox(width: 8),
              itemBuilder: (context, index) => InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductDetailsScreen(
                            productSale: productsSale.elementAt(index)))),
                child: Container(
                  width: 160,
                  height: 180,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Color.fromRGBO(236, 232, 231, 1)),
                  child: Column(
                    children: [
                      Container(
                        height: 120.0,
                        width: 160.0,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15)),
                          image: DecorationImage(
                            image: NetworkImage(productsSale
                                    .elementAt(index)
                                    .product!
                                    .photos
                                    .first
                                    .link ??
                                "https://assets.bonappetit.com/photos/63a390eda38261d1c3bdc555/4:5/w_1920,h_2400,c_limit/best-food-writing-2022-lede.jpg"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const SizedBox(height: 2),
                      SizedBox(
                          width: 150,
                          child: Text(
                              productsSale.elementAt(index).product!.name ??
                                  'Based')),
                      const SizedBox(height: 23),
                      SizedBox(
                          width: 150,
                          child: Text(productsSale.elementAt(index).price))
                    ],
                  ),
                ),
              ),
              itemCount: productsSale.length,
            ))
      ],
    );
  }
}
