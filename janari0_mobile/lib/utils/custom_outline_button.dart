import 'package:flutter/material.dart';

import '../model/product.dart';
import '../screens/show_products_screen.dart';

class CustomOutlineButton extends StatefulWidget {
  final String text;
  final Color color;
  final List<Product> products;
  const CustomOutlineButton(
      {super.key,
      required this.text,
      required this.color,
      required this.products});

  @override
  State<StatefulWidget> createState() => _CustomOutlineButton();
}

class _CustomOutlineButton extends State<CustomOutlineButton> {
  @override
  Widget build(BuildContext context) {
    void showProducts() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ShowProducts(
                    products: widget.products,
                    text: widget.text,
                  ))).then((value) => setState(() {}));
    }

    return Column(
      children: [
        Text(widget.text),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: OutlinedButton(
              style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  side: BorderSide(color: widget.color, width: 1),
                  backgroundColor: Colors.white),
              onPressed: () => showProducts(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  widget.products.length.toString(),
                  style: TextStyle(fontSize: 32, color: widget.color),
                ),
              )),
        ),
      ],
    );
  }
}
