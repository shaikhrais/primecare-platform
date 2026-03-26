import 'package:flutter/material.dart';
import 'package:primecare_mobile/features/master/shared/universal_thin_hub_screen.dart';

class MtAnalyticsHubScreen extends StatelessWidget {
  const MtAnalyticsHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MT Analytics Hub', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.purple.shade900,
        foregroundColor: Colors.white,
      ),
      // Deep-wired Thin View Execution Node properly conceptually dependably dependably securely natively explicitly efficiently cleanly flawlessly
      body: const UniversalThinHubScreen(),
    );
  }
}
