import 'package:flutter/material.dart';

class KTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? suffix;
  final double? textFontSize;
  final TextStyle? textStyle;
  final Widget? prefixImage;
  final int? maxLines;
  final TextInputType? keyboardType;
  const KTextField(
      {super.key,
      this.suffix,
      this.textStyle,
      this.maxLines,
      required this.controller,
      this.prefixImage,
      this.keyboardType,
      this.textFontSize});

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
      controller: controller,
      style: TextStyle(fontSize: textFontSize, fontWeight: FontWeight.bold),
      keyboardType: keyboardType,
      decoration: InputDecoration(
          prefixIcon: prefixImage,
          suffix: Text(
            suffix ?? "",
            style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }
}
