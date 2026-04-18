import 'package:primecare_ui/src/theme/colors.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

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
                'Set New Password',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: PrimeCareColors.white,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  prefixIcon: Icon(
                    Icons.lock,
                    color: PrimeCareColors.white.withValues(alpha: 0.6),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                style: const TextStyle(color: PrimeCareColors.white),
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: PrimeCareColors.white.withValues(alpha: 0.6),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                style: const TextStyle(color: PrimeCareColors.white),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Update Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
