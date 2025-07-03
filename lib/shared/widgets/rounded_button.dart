import 'package:flutter/material.dart';
import 'package:pdf_reader/core/theme/colors.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    required this.title,
    super.key,
    this.onPressed,
    this.cornerRadius = 12.0,
    this.backgroundColor = primaryColor,
    this.foregroundColor = Colors.white,
    this.padding,
    this.minimumSize,
    this.maximumSize,
  });

  final String title;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Size? minimumSize;
  final Size? maximumSize;
  final void Function()? onPressed;

  final double cornerRadius;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        minimumSize: minimumSize,
        maximumSize: maximumSize,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cornerRadius),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
      child: Text(title),
    );
  }
}
