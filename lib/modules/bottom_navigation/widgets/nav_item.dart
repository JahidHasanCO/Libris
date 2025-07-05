import 'package:flutter/material.dart';
import 'package:pdf_reader/core/theme/colors.dart';

class NavItem extends StatelessWidget {
  const NavItem({
    required this.icon,
    required this.isSelected,
    this.isAddButton = false,
    super.key,
  });

  final IconData icon;
  final bool isAddButton;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    if (isAddButton) {
      return Container(
        width: 52,
        height: 52,
        decoration: const BoxDecoration(
          color: primaryColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 30,
          color: Colors.white,
        ),
      );
    }

    return Icon(
      icon,
      size: isSelected ? 30 : 26,
      color: isSelected ? primaryColor : Colors.grey.shade600,
    );
  }
}
