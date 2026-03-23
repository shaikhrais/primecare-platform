import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:primecare_ui/primecare_ui.dart';
import '../../core/widgets/global_top_bar.dart';
import 'package:primecare_mobile/l10n/app_localizations.dart';

class ClientDashboardScreen extends StatelessWidget {
  const ClientDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PrimeCareScaffold(
      body: PrimeCareCenter(
        child: DesktopPaneWrapper(
          child: PrimeCarePadding(
            padding: EdgeInsets.all(24.0),
        child: PrimeCareColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrimeCareText(
              'Care Transparency Feed',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: PrimeCareColors.radarDark),
            ),
            SizedBox(height: 8),
            PrimeCareText(
              'Monitor upcoming visits and clinical progress notes.',
              style: TextStyle(fontSize: 16, color: PrimeCareColors.slate500),
            ),
            SizedBox(height: 32),
            PrimeCareExpanded(
              child: PrimeCareCenter(
                child: PrimeCareColumn(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PrimeCareIcon(Icons.volunteer_activism, size: 64, color: PrimeCareColors.slate400),
                    SizedBox(height: 16),
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
