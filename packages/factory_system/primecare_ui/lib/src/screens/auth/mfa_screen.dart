import 'package:primecare_ui/src/theme/colors.dart';
import 'package:flutter/material.dart';

class MFAScreen extends StatelessWidget {
  const MFAScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PrimeCareColors.black.withValues(alpha: 0.87),
      body: Center(
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: PrimeCareColors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: PrimeCareColors.white.withValues(alpha: 0.1),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Two-Factor Authentication',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: PrimeCareColors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Please enter the 6-digit code sent to your device.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: PrimeCareColors.white.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: InputDecoration(
                  counterText: "",
                  hintText: '000000',
                  hintStyle: TextStyle(color: Colors.white30, letterSpacing: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                style: const TextStyle(
                  color: PrimeCareColors.white,
                  fontSize: 24,
                  letterSpacing: 8,
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Verify Code'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Using dynamicPageProvider and ViewModel pattern for data binding.
