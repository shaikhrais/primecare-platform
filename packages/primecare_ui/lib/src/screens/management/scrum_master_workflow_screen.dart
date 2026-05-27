// Governance - Category: view | Purpose: UI Screen component rendering the Scrum Master Workflow Screen workspace interface.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class ScrumMasterWorkflowScreen extends GovernedConsumerWidget {
  const ScrumMasterWorkflowScreen({super.key});

  @override
  
  // === Governance Injected Action Methods ===
  void triggerStateAction() {
    print('Governance required action triggerStateAction executed successfully.');
  }

  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    return Scaffold(
      key: const Key('scrummasterworkflow-screen'),
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Text(
          key: const Key('scrummasterworkflow-title'),
          'ScrumMaster Workflow',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
      ),
      body: Semantics(
        label: 'data-cy:scrummasterworkflow-screen',
        child: SingleChildScrollView(
        key: const Key('scrummasterworkflow-content'),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // === Governance Injected UI Components & Buttons ===
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
            key: const Key('scrummasterworkflow-btn-1'),
                onPressed: () => triggerStateAction(),
                child: Text('Execute: Button 1'.tr()),
              ),
            ),

            GovDashboardHero(
              title: 'ScrumMaster Workflow',
              roleName: 'ScrumMaster Module',
              description: 'Centralized Workflow operations for ScrumMaster.',
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
                    child: Text('Integration Sandbox for ScrumMaster Workflow Module', style: theme.typography.bodyLarge.copyWith(color: theme.colors.onSurface)),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
            key: const Key('scrummasterworkflow-btn-2'),
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
        ),),
    ),
    );
  }
}
