import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class ClinicAnalyticsScreen extends GovernedConsumerWidget {
  const ClinicAnalyticsScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Text(
          'Clinic Analytics',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GovDashboardHero(
              title: 'Clinic Analytics',
              roleName: 'Clinic Module',
              description: 'Centralized Analytics operations for Clinic.',
              onRefresh: () {},
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.colors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: theme.colors.border),
              ),
              child: Center(
                child: Text('Integration Sandbox for Clinic Analytics Module', style: theme.typography.bodyLarge.copyWith(color: theme.colors.onSurface)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
