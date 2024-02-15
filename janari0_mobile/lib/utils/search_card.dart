import 'package:flutter/material.dart';
import '../model/product_sale.dart';

class SearchCard extends StatelessWidget {
  final ProductSale productSale;
  const SearchCard({super.key, required this.productSale});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(
      children: [
        Image(
          image: NetworkImage(productSale.product!.photos.isNotEmpty
              ? productSale.product!.photos.first.link!
              : 'https://assets.bonappetit.com/photos/63a390eda38261d1c3bdc555/4:5/w_1920,h_2400,c_limit/best-food-writing-2022-lede.jpg'),
          fit: BoxFit.fitWidth, // use this
          height: 60,
          width: 120,
        ),
        const SizedBox(
          width: 50,
        ),
        Text(productSale.product!.name!),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Text(productSale.price == "Free"
              ? productSale.price
              : "\$${productSale.price}"),
        )
      ],
    ));
  }
}
