import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class HeadBusinessDevelopmentReportsWidget extends StatelessWidget {
  const HeadBusinessDevelopmentReportsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareScrollWrapper(
      physics: const BouncingScrollPhysics(),
      child: PrimeCareContainer(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const PrimeCareText('Head of Business Development Reports', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const PrimeCareSizedBox(height: 16),
            const UrgentAlertBanner(
              message: 'Connecting to Corporate / Head Office Data Modules for Reports...'
            ),
          ]
        ),
      )
    );
  }
}
