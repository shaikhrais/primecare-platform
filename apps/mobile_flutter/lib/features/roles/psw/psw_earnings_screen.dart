import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class PswEarningsScreen extends StatelessWidget {
  const PswEarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: PrimeCareAppBar(title: 'Earnings Report'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            PrimeCareSectionHeader(title: 'Earnings Overview', isWhite: true),
            PrimeCareCardContainer(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Text('Total Earnings This Period: \$1,240.50'),
                  const SizedBox(height: 16),
                  ElevatedButton(onPressed: () {}, child: Text('View Details')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
