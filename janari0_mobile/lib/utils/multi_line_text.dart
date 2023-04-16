import 'package:flutter/material.dart';

class MultiLineTextField extends StatefulWidget {
  final GlobalKey globalKey;
  final TextEditingController controller;
  const MultiLineTextField(
      {super.key, required this.globalKey, required this.controller});
  @override
  _MultiLineTextFieldState createState() => _MultiLineTextFieldState();
}

class _MultiLineTextFieldState extends State<MultiLineTextField> {
  // text controller to handle user entered data in textfield
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: widget.controller,
              minLines: 3,
              maxLines: 5,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                  hintText: 'Description',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
