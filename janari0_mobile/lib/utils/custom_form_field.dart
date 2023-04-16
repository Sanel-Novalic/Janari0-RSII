import 'package:flutter/material.dart';

class CustomFormField {
  Material field(
      {required String question,
      //
      bool canBeNull = false,
      //
      double? fieldTextFontSize,
      //
      String? initialValue,
      //
      double? verticalTextPadding,
      double? horizontalTextPadding,
      //
      Icon? icon,
      //
      TextEditingController? controller,
      double? borderRadius,
      //
      TextStyle? labelTextStyle,
      //
      Color? borderColor}) {
    BorderRadius borderRadius_;
    borderRadius != null
        ? borderRadius_ = BorderRadius.circular(borderRadius)
        : borderRadius_ = BorderRadius.circular(25.0);

    //
    return Material(
        color: Colors.transparent,
        child: TextFormField(
          controller: controller,
          maxLines: null,
          initialValue: initialValue,
          textAlign: TextAlign.left,
          cursorColor: Colors.black,
          style: TextStyle(
            fontSize: fieldTextFontSize,
          ),
          decoration: InputDecoration(
            labelText: question,
            contentPadding: EdgeInsets.symmetric(
                vertical: verticalTextPadding ?? 10,
                horizontal: horizontalTextPadding ?? 6),
            errorBorder: OutlineInputBorder(
              borderRadius: borderRadius_,
              borderSide: BorderSide(color: borderColor ?? Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: borderRadius_,
              borderSide: BorderSide(color: borderColor ?? Colors.white),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: borderRadius_,
              borderSide: BorderSide(color: borderColor ?? Colors.white),
            ),
            border: OutlineInputBorder(
              borderRadius: borderRadius_,
              borderSide: BorderSide(color: borderColor ?? Colors.white),
            ),
            labelStyle: labelTextStyle ??
                TextStyle(fontSize: fieldTextFontSize, color: Colors.grey[700]),
            suffixIcon: icon,
          ),
          validator: (String? value) {
            if (value!.trim().isEmpty && !canBeNull) {
              return 'Required';
            }
            return null;
          },
        ));
  }
}
