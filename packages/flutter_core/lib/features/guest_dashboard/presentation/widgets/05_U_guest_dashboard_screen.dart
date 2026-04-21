// Layer: 05_UI_PRESENTATION
import 'package:flutter/material.dart';
import 'package:primecare_core/00_B_flutter_core.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';

/// High-Fidelity Guest Landing Page
class GuestDashboardScreen extends ConsumerWidget {
  final DashboardMetrics? data;
  
  const GuestDashboardScreen({super.key, this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    
    return PrimeCareScaffold(
      title: 'Welcome to PrimeCare',
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(LucideIcons.home, size: 80, color: theme.colors.primary),
            SizedBox(height: theme.spacing.xl),
            Text(
              'Your Institutional Hub',
              style: theme.typography.h1,
            ),
            SizedBox(height: theme.spacing.sm),
            Text(
              'Please sign in to access your role-based dashboard.',
              style: theme.typography.bodyLarge.copyWith(color: theme.colors.slateGray),
            ),
            SizedBox(height: theme.spacing.xl),
            PrimeCareButton(
              label: 'Access Platform',
              onPressed: () {},
              type: PrimeCareButtonType.primary,
            ),
          ],
        ),
      ),
    );
  }
}
