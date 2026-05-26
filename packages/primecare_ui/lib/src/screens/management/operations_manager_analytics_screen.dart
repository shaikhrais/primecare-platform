// Governance - Category: view | Purpose: UI Screen component rendering the Operations Manager Analytics Screen workspace interface.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class OperationsManagerAnalyticsScreen extends GovernedConsumerWidget {
  const OperationsManagerAnalyticsScreen({super.key});

  @override
  
  // === Governance Injected Action Methods ===
  void triggerStateAction() {
    print('Governance required action triggerStateAction executed successfully.');
  }

  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    return Scaffold(
      key: const Key('operationsmanageranalytics-screen'),
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Text(
          key: const Key('operationsmanageranalytics-title'),
          'OperationsManager Analytics',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
      ),
      body: Semantics(
        label: 'data-cy:operationsmanageranalytics-screen',
        child: SingleChildScrollView(
        key: const Key('operationsmanageranalytics-content'),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // === Governance Injected UI Components & Buttons ===
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
            key: const Key('operationsmanageranalytics-btn-1'),
            key: const Key('operationsmanageranalytics-btn-1'),
            key: const Key('operationsmanageranalytics-btn-1'),
                onPressed: () => triggerStateAction(),
                child: Text('Execute: Button 1'.tr()),
              ),
            ),

            GovDashboardHero(
              title: 'OperationsManager Analytics',
              roleName: 'OperationsManager Module',
              description: 'Centralized Analytics operations for OperationsManager.',
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text('Integration Sandbox for OperationsManager Analytics Module', style: theme.typography.bodyLarge.copyWith(color: theme.colors.onSurface)),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
            key: const Key('operationsmanageranalytics-btn-2'),
            key: const Key('operationsmanageranalytics-btn-2'),
            key: const Key('operationsmanageranalytics-btn-2'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () => triggerStateAction(),
                      child: Text(
                        'Execute Action Sweep',
                        style: theme.typography.button.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
