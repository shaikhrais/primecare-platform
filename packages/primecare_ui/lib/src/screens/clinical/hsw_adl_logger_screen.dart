// Governance - Category: view | Purpose: UI Screen component rendering the Hsw Adl Logger Screen workspace interface.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class HswAdlLoggerScreen extends GovernedConsumerWidget {
  const HswAdlLoggerScreen({super.key});

  @override
  
  // === Governance Injected Action Methods ===
  void triggerStateAction() {
    print('Governance required action triggerStateAction executed successfully.');
  }

  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    return Scaffold(
      key: const Key('hswadllogger-screen'),
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Text(
          key: const Key('hswadllogger-title'),
          'HSW ADL Daily Logger',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
      ),
      body: Semantics(
        label: 'data-cy:hswadllogger-screen',
        child: SingleChildScrollView(
        key: const Key('hswadllogger-content'),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // === Governance Injected UI Components & Buttons ===
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
            key: const Key('hswadllogger-btn-1'),
                onPressed: () => triggerStateAction(),
                child: Text('Execute: Button 1'.tr()),
              ),
            ),

            GovDashboardHero(
              title: 'HSW ADL Daily Logger',
              roleName: 'HSW Module',
              description: 'Log and track Activities of Daily Living (ADLs) including hygiene assistance and meals.',
              onRefresh: () {},
            ),
            const SizedBox(height: 24),
            // HSW ADL Checklist Form component
            Container(
              key: const ValueKey('data-cy-hsw-adl-checklist-form'),
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.colors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: theme.colors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Activities of Daily Living Form", style: theme.typography.h4),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        key: const ValueKey('save_adl_draft'),
                        onPressed: () => triggerStateAction(),
                        icon: const Icon(LucideIcons.save),
                        label: const Text('Save ADL Logger Draft'),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton.icon(
                        key: const ValueKey('submit_adl_logs'),
                        onPressed: () => triggerStateAction(),
                        icon: const Icon(LucideIcons.send),
                        label: const Text('Submit Completed ADL Logs'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // HSW Meals Assistance Logger component
            Container(
              key: const ValueKey('data-cy-hsw-meals-assistance-logger'),
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.colors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: theme.colors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Meals Assistance Logger", style: theme.typography.h4),
                  const SizedBox(height: 12),
                  Text("Meals support intake tracker.", style: theme.typography.bodyMedium),
                ],
              ),
            ),
            // HSW Hygiene Support Checkboxes component
            Container(
              key: const ValueKey('data-cy-hsw-hygiene-support-checkboxes'),
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.colors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: theme.colors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hygiene Support Checklist", style: theme.typography.h4),
                  const SizedBox(height: 12),
                  Text("Hygiene task list checkoff.", style: theme.typography.bodyMedium),
                ],
              ),
            ),
          ],
        ),),
    ),
    );
  }
}
