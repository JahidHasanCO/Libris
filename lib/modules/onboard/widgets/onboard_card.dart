import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pdf_reader/core/theme/colors.dart';
import 'package:pdf_reader/shared/models/models.dart';

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
          height: 400,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  onboard.path,
                  fit: BoxFit.cover,
                ),
              ),
              // Blur filter
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 100,
                    sigmaY: 100,
                    tileMode: TileMode.clamp,
                  ),
                  child: Container(color: Colors.transparent),
                ),
              ),
              // Foreground focused image
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
