import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:janari0/screens/donate_product_screen.dart';

import '../model/product.dart';
import '../model/user.dart';
import '../screens/add_product_name_screen.dart';

class ExpandableSponsorFloatingButton extends StatelessWidget {
  final List<Product> products;
  final User user;
  const ExpandableSponsorFloatingButton(
      {super.key, required this.products, required this.user});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Colors.white;
    final textColor = Theme.of(context).colorScheme.tertiary;

    return Positioned(
      right: 8,
      bottom: (Platform.isAndroid ? 10 : 10),
      child: SpeedDial(
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey,
        icon: Icons.add,
        activeIcon: Icons.close,
        spacing: 10,
        renderOverlay: false,
        children: [
          SpeedDialChild(
              backgroundColor: primaryColor,
              foregroundColor: textColor,
              child: const Icon(Icons.add_shopping_cart),
              label: 'Add product',
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddProductName(
                            user: user,
                          )))),
          SpeedDialChild(
              backgroundColor: primaryColor,
              foregroundColor: textColor,
              child: const Icon(Icons.hdr_plus),
              label: 'Donate product',
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DonateProductScreen(
                            products: products,
                            hasPrice: false,
                            user: user,
                          )))),
          SpeedDialChild(
              backgroundColor: primaryColor,
              foregroundColor: textColor,
              child: const Icon(Icons.hdr_plus),
              label: 'Sell product',
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DonateProductScreen(
                            products: products,
                            hasPrice: true,
                            user: user,
                          )))),
        ],
      ),
    );
  }
}
