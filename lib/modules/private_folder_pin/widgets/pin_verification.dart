import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf_reader/core/provider/provider.dart';
import 'package:pdf_reader/core/theme/pin_theme.dart';
import 'package:pdf_reader/shared/validators/pin_validator.dart';
import 'package:pdf_reader/shared/widgets/widgets.dart';
import 'package:pinput/pinput.dart';

class PinVerification extends ConsumerStatefulWidget with PinValidator {
  const PinVerification({super.key});

  @override
  PinVerificationState createState() => PinVerificationState();
}

class PinVerificationState extends ConsumerState<PinVerification> {
  TextEditingController pinController = TextEditingController();

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  void listenForPinVerification(WidgetRef ref) {
    ref.listen(privateFolderPinProvider.select((s) => s.isVerified), (
      previous,
      next,
    ) {
      if (previous != next && next) {
        if (ref.context.mounted) {
          Navigator.of(ref.context).pop();
        }
      }
    });
  }

  void listenForMessage(WidgetRef ref) {
    ref.listen(privateFolderPinProvider.select((s) => s.message), (
      previous,
      next,
    ) {
      if ((previous?.isEmpty ?? true) && next.isNotEmpty) {
        if (ref.context.mounted) {
          ScaffoldMessenger.of(ref.context).showSnackBar(
            SnackBar(content: Text(next)),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    listenForPinVerification(ref);
    listenForMessage(ref);
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 180,
          child: Stack(
            children: [
              Positioned.fill(
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                  child: Image.asset(
                    'assets/images/pin.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Blur filter
              Center(
                child: Image.asset(
                  'assets/images/pin.png',
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: 120,
                  errorBuilder: (context, url, error) =>
                      const Icon(Icons.error),
                ),
              ),
            ],
          ),
        ),
        const Text(
          'Enter your PIN',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Pinput(
          controller: pinController,
          onCompleted: (pin) {},
          obscureText: true,
          validator: widget.validatePin,
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: focusedPinTheme,
          errorPinTheme: errorPinTheme,
        ),
        const SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: RoundedButton(
            minimumSize: const Size(double.infinity, 50),
            onPressed: () {
              ref
                  .read(privateFolderPinProvider.notifier)
                  .verifyPin(pinController.text);
            },
            title: 'Submit',
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
