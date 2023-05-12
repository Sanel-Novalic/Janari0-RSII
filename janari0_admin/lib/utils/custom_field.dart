import 'package:flutter/material.dart';
import 'package:janari0/utils/custom_form_field.dart';

class CustomField extends StatelessWidget {
  final TextEditingController controller;
  final String question;
  const CustomField(
      {super.key, required this.controller, required this.question});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomFormField().field(
          controller: controller,
          question: question,
          horizontalTextPadding: 20,
          verticalTextPadding: 10,
          labelTextStyle:
              const TextStyle(color: Colors.white, background: null),
          icon: const Icon(
            Icons.key,
            color: Colors.grey,
            size: 25,
          ),
          fieldTextFontSize: 15,
          borderColor: Colors.white,
          cursorColor: Colors.white),
    );
  }
}
