import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class DirectorOfNursingClientsWidget extends StatelessWidget {
  const DirectorOfNursingClientsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareScrollWrapper(
      physics: const BouncingScrollPhysics(),
      child: PrimeCareContainer(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const PrimeCareText('Director of Nursing (DON) Clients', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const PrimeCareSizedBox(height: 16),
            const UrgentAlertBanner(
              message: 'Connecting to Corporate / Head Office Data Modules for Clients...'
            ),
          ]
        ),
      )
    );
  }
}
