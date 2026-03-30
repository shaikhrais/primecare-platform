import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class PswStaffWidget extends StatelessWidget {
  const PswStaffWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareScrollWrapper(
      physics: const BouncingScrollPhysics(),
      child: PrimeCareContainer(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const PrimeCareText('PSW Staff', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const PrimeCareSizedBox(height: 16),
            const UrgentAlertBanner(
              message: 'Connecting to Clinical Team Data Modules for Staff...'
            ),
          ]
        ),
      )
    );
  }
}
