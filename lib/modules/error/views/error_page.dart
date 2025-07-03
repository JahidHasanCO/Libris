import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pdf_reader/core/theme/colors.dart';
import 'package:pdf_reader/router/router.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Page Not Found',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.warning_rounded,
              size: 100,
              color: greyColor,
            ),
            const SizedBox(height: 20),
            const Text(
              '404 - Page Not Found',
              style: TextStyle(fontSize: 24, color: greyColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () => context.go(Routes.onboard),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
