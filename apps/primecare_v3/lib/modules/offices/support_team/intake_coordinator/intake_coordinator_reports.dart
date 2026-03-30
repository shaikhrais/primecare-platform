import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class IntakeCoordinatorReportsWidget extends StatelessWidget {
  const IntakeCoordinatorReportsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareScrollWrapper(
      physics: const BouncingScrollPhysics(),
      child: PrimeCareContainer(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const PrimeCareText('Intake Coordinator Reports', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const PrimeCareSizedBox(height: 16),
            const UrgentAlertBanner(
              message: 'Connecting to Support Team Data Modules for Reports...'
            ),
          ]
        ),
      )
    );
  }
}
