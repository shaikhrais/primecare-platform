import 'package:primecare_ui/src/theme/colors.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

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
                'Forgot Password',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: PrimeCareColors.white,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  prefixIcon: Icon(
                    Icons.email,
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
                child: const Text('Send Reset Link'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
