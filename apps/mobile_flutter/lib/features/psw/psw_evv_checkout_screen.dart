import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:flutter/services.dart';
import '../../core/widgets/primecare_app_bar.dart';

class PswEvvCheckoutScreen extends StatelessWidget {
  const PswEvvCheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: const PrimeCareAppBar(title: 'Shift Checkout Protocol'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // High Fidelity Validation Badge
              const Icon(Icons.verified_user_rounded, size: 80, color: PrimeCareColors.emerald),
              const SizedBox(height: 24),
              Text(
                'Verification Complete', 
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: PrimeCareColors.emerald), 
                textAlign: TextAlign.center
              ),
              const SizedBox(height: 12),
              const Text(
                'All mandatory Schedule Tasks have been intercepted. Please provide client signature verification to officially break the EVV lock.', 
                textAlign: TextAlign.center, 
                style: TextStyle(color: PrimeCareColors.slate500, fontSize: 16, height: 1.5)
              ),
              
              const SizedBox(height: 40),
              
              const Text(
                'CLIENT CONSENT SIGNATURE',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: PrimeCareColors.slate500, letterSpacing: 1.2),
              ),
              const SizedBox(height: 12),
              
              // Signature Pad Native Frame (Placeholder layout for tactile interaction)
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: PrimeCareColors.slate200, width: 3),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.draw_rounded, color: PrimeCareColors.slate300, size: 48),
                        SizedBox(height: 12),
                        Text('Client must sign here using their finger', style: TextStyle(color: PrimeCareColors.slate400, fontSize: 16)),
                      ],
                    ),
                  )
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Termination Interaction
              ElevatedButton(
                onPressed: () {
                   HapticFeedback.heavyImpact();
                   // Pop multiple stacks representing completion of flow natively
                   Navigator.of(context).pop(); 
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: PrimeCareColors.rose,
                  padding: const EdgeInsets.symmetric(vertical: 20), // Thumb-Zone scale up
                ),
                child: const Text('SECURE CHECKOUT & END SHIFT', style: TextStyle(letterSpacing: 0.5)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
