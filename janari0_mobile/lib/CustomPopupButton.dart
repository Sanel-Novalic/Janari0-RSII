import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'screens/AddProduct.dart';

class ExpandableSponsorFloatingButton extends StatelessWidget {
  const ExpandableSponsorFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Colors.white;
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
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddProduct()))),
          SpeedDialChild(
            backgroundColor: primaryColor,
            foregroundColor: textColor,
            child: const Icon(Icons.hdr_plus),
            label: 'Donate product',
          ),
          SpeedDialChild(
            backgroundColor: primaryColor,
            foregroundColor: textColor,
            child: const Icon(Icons.hdr_plus),
            label: 'Sell product',
          ),
        ],
      ),
    );
  }
}
