import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:primecare_ui/primecare_ui.dart';

class ClientDashboardScreen extends StatelessWidget {
  const ClientDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: PrimeCareCenter(
        child: DesktopPaneWrapper(
          child: PrimeCarePadding(
            padding: const EdgeInsets.all(24.0),
        child: PrimeCareColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PrimeCareText(
              'Care Transparency Feed',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: PrimeCareColors.radarDark),
            ),
            const PrimeCareSizedBox(height: 8),
            const PrimeCareText(
              'Monitor upcoming visits and clinical progress notes.',
              style: TextStyle(fontSize: 16, color: PrimeCareColors.slate500),
            ),
            const PrimeCareSizedBox(height: 32),
            PrimeCareExpanded(
              child: PrimeCareCenter(
                child: PrimeCareColumn(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    PrimeCareIcon(Icons.volunteer_activism, size: 64, color: PrimeCareColors.slate400),
                    PrimeCareSizedBox(height: 16),
                    PrimeCareText('No active visits scheduled.', style: TextStyle(color: PrimeCareColors.slate500)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      ),
      ),
    );
  }
}
