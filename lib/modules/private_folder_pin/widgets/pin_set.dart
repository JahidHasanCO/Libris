import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libris/core/provider/provider.dart';
import 'package:libris/core/theme/colors.dart';
import 'package:libris/core/theme/pin_theme.dart';
import 'package:libris/shared/validators/pin_validator.dart';
import 'package:libris/shared/widgets/rounded_button.dart';
import 'package:pinput/pinput.dart';

class PinSet extends ConsumerStatefulWidget with PinValidator {
  const PinSet({super.key});

  @override
  PinSetState createState() => PinSetState();
}

class PinSetState extends ConsumerState<PinSet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController pinController = TextEditingController();
  TextEditingController confirmPinController = TextEditingController();

  @override
  void dispose() {
    pinController.dispose();
    confirmPinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
            'Set your PIN',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Enter your PIN',
                  style: TextStyle(
                    fontSize: 16,
                    color: textColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Pinput(
                  controller: pinController,
                  onCompleted: (pin) {},
                  obscureText: true,
                  validator: widget.validatePin,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  errorPinTheme: errorPinTheme,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Confirm your PIN',
                  style: TextStyle(
                    fontSize: 16,
                    color: textColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Pinput(
                  controller: confirmPinController,
                  onCompleted: (pin) {},
                  obscureText: true,
                  validator: (value) => widget.validatePinConfirmation(
                    value,
                    pinController.text,
                  ),
                  crossAxisAlignment: CrossAxisAlignment.center,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  errorPinTheme: errorPinTheme,
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: RoundedButton(
              minimumSize: const Size(double.infinity, 50),
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  ref
                      .read(privateFolderPinProvider.notifier)
                      .setPin(pinController.text);
                }
              },
              title: 'Set PIN',
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
