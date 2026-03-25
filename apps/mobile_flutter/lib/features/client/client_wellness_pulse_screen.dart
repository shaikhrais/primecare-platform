import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class ClientWellnessPulseScreen extends StatelessWidget {
  const ClientWellnessPulseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daily Wellness Pulse')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const PulseRadialGauge(),
              const SizedBox(height: 48),
              const Text(
                'How are you feeling today?',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              const MoodSliderWidget(),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                child: PrimeButton(label: 'SUBMIT MY PULSE', onPressed: () {}),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
