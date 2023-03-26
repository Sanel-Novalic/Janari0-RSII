import 'package:flutter/material.dart';

class CustomOutlineButton extends StatelessWidget {
  final String text;
  final int number;
  final Color color;
  const CustomOutlineButton(
      {super.key,
      required this.text,
      required this.number,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(text),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: OutlinedButton(
              style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  side: BorderSide(color: color, width: 1),
                  backgroundColor: Colors.white),
              onPressed: () => null,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  number.toString(),
                  style: TextStyle(fontSize: 32, color: color),
                ),
              )),
        ),
      ],
    );
  }
}
