import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class PswHomeScreen extends StatelessWidget {
  const PswHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const GreetingHeaderWidget(name: 'Sarah'),
              const SizedBox(height: 24),
              const NextShiftActionCard(),
              const SizedBox(height: 24),
              const Center(child: DailyProgressRing(progress: 0.75)),
              const SizedBox(height: 24),
              const UrgentAlertBanner(
                message: 'Severe weather alert in Region 4.',
              ),
              const SizedBox(height: 24),
              PrimeButton(
                label: 'View Full Schedule',
                isOutline: true,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
