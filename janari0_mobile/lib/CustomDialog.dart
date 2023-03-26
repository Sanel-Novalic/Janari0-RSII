import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialog {
  static void show(
    context,
    String heading,
    String subHeading,
    String positiveButtonText,
    Function onPressedPositive, {
    String? negativeButtonText,
    Function? onPressedNegative,
    bool showNegativeButton = true,
    bool isPositiveButtonDangerous = false,
  }) {
    showDialog(
      useRootNavigator: false,
      context: context,
      builder: (_) => AlertDialog(
        title: _buildTitle(context, heading),
        content: _buildSubTitle(context, subHeading),
        actions: _buildActions(
          context,
          positiveButtonText,
          onPressedPositive,
          negativeButtonText!,
          onPressedNegative!,
          showNegativeButton,
          isPositiveButtonDangerous,
        ),
      ),
    );
  }

  static _buildTitle(context, String heading) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Text(heading, style: TextStyle(fontSize: 18)),
    );
  }

  static _buildSubTitle(context, String subHeading) {
    if (subHeading.isNotEmpty) {
      return Text(
        subHeading,
        style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
      );
    }
    return SizedBox.shrink();
  }

  static List<Widget> _buildActions(
      context,
      String positiveButtonText,
      Function onPressedPositive,
      String negativeButtonText,
      Function onPressedNegative,
      bool showNegativeButton,
      bool isPositiveButtonDangerous) {
    return [
      if (showNegativeButton)
        TextButton(
          style: TextButton.styleFrom(
            primary: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(2.0)),
            ),
            backgroundColor: Colors.blue,
          ),
          onPressed: () {
            if (onPressedNegative != null) {
              onPressedNegative();
            } else {
              Navigator.pop(context);
            }
          },
          child: Text(
            negativeButtonText,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: isPositiveButtonDangerous ? Colors.black : Colors.red),
          ),
        ),
      TextButton(
        style: TextButton.styleFrom(
          primary: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(2.0)),
          ),
          backgroundColor: Colors.blue,
        ),
        onPressed: onPressedPositive(),
        child: Text(
          positiveButtonText,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isPositiveButtonDangerous ? Colors.red : Colors.black,
          ),
        ),
      ),
    ];
  }
}
