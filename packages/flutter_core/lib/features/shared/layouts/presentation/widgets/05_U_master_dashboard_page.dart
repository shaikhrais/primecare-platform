// Layer: 05_UI_PRESENTATION
import 'package:flutter/material.dart';
import 'package:primecare_core/00_B_flutter_core.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';

/// The Unified Entry Point for all High-Fidelity Dashboards.
/// This page dynamically resolves the child dashboard based on the user's role.
class MasterDashboardPage extends ConsumerWidget {
  const MasterDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    
    // In a real scenario, this would use role-based routing.
    // For now, it acts as the PDM-valid shell for the main dashboard intent.
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(LucideIcons.layoutDashboard, size: 48, color: theme.colors.primary),
            SizedBox(height: theme.spacing.lg),
            Text('PrimeCare Master Dashboard', style: theme.typography.h2),
            Text('Select a role-based workspace from the sidebar.', style: theme.typography.bodyLarge),
          ],
        ),
      ),
    );
  }
}
