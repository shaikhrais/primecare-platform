// Layer: 05_UI_PRESENTATION
import 'package:easy_localization/easy_localization.dart';
import 'package:primecare_ui/src/theme/01_I_colors.dart';
import 'package:flutter/material.dart';

class MFAScreen extends StatelessWidget {
  const MFAScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PrimeCareColors.radarDark,
      body: Center(
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: PrimeCareColors.slate800,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: PrimeCareColors.white.withValues(alpha: 0.1),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'auth.mfa.title'.tr(),
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: PrimeCareColors.white,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'auth.mfa.subtitle'.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: PrimeCareColors.white.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 32),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: InputDecoration(
                  counterText: '',
                  hintText: '000000',
                  hintStyle: const TextStyle(
                    color: Colors.white30,
                    letterSpacing: 8,
                  ),
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
