import 'package:flutter/material.dart';

import '../model/user.dart';

class LongWhiteButton extends StatelessWidget {
  final String text;
  final String value;
  final User user;
  final Function onPressed;
  const LongWhiteButton(
      {super.key,
      required this.text,
      required this.value,
      required this.user,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    print("wdawdaw${user.userId}");
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0, right: 18, top: 5),
        child: ElevatedButton(
            onPressed: () => onPressed,
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7))),
            child: Row(
              children: [
                const SizedBox(
                  width: 12,
                ),
                Text(
                  text,
                  style: const TextStyle(color: Colors.black),
                ),
                const Spacer(),
                Text(
                  value,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(
                  width: 12,
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 12,
                )
              ],
            )),
      ),
    );
  }
}
