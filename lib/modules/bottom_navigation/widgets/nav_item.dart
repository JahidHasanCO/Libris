import 'package:flutter/material.dart';
import 'package:pdf_reader/core/theme/colors.dart';

class NavItem extends StatelessWidget {
  const NavItem({
    required this.icon,
    required this.isSelected,
    super.key,
  });

  final IconData icon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: isSelected ? 30 : 26,
      color: isSelected ? primaryColor : Colors.grey.shade600,
    );
  }
}
