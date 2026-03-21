import 'package:flutter/material.dart';
import '../../core/colors.dart';

import '../shared/layouts/desktop_pane_wrapper.dart';

class ClientDashboardScreen extends StatelessWidget {
  const ClientDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Center(
        child: DesktopPaneWrapper(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Care Transparency Feed',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: PrimeCareColors.radarDark),
            ),
            const SizedBox(height: 8),
            const Text(
              'Monitor upcoming visits and clinical progress notes.',
              style: TextStyle(fontSize: 16, color: PrimeCareColors.slate500),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.volunteer_activism, size: 64, color: PrimeCareColors.slate400),
                    SizedBox(height: 16),
                    Text('No active visits scheduled.', style: TextStyle(color: PrimeCareColors.slate500)),
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
