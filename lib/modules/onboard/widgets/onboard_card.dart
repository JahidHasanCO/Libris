import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:libris/core/theme/colors.dart';
import 'package:libris/shared/models/models.dart';

class OnboardCard extends StatelessWidget {
  const OnboardCard({required this.onboard, super.key});

  final Onboard onboard;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: double.infinity,
          height: 450,
          child: Stack(
            children: [
              Positioned.fill(
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                  child: Image.asset(
                    onboard.path,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Blur filter
              Center(
                child: Image.asset(
                  onboard.path,
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: 300,
                  errorBuilder: (context, url, error) =>
                      const Icon(Icons.error),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            onboard.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: textColor,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            onboard.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: textGrayColor,
            ),
          ),
        ),
      ],
    );
  }
}
