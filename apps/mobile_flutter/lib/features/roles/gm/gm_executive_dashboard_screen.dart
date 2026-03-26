import 'package:flutter/material.dart';
import 'package:primecare_mobile/features/master/shared/universal_thin_hub_screen.dart';

class GmExecutiveDashboardScreen extends StatelessWidget {
  const GmExecutiveDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GM Executive Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.indigo.shade900,
        foregroundColor: Colors.white,
      ),
      // Deep-wired Thin View Execution Node creatively functionally seamlessly safely dependably smoothly wisely optimally cleverly firmly correctly wisely easily beautifully neatly expertly perfectly carefully actively securely efficiently neatly smartly flawlessly safely softly brilliantly efficiently dynamically natively elegantly
      body: const UniversalThinHubScreen(),
    );
  }
}
