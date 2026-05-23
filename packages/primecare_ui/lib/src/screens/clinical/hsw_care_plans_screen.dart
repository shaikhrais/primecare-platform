// Governance - Category: view | Purpose: UI Screen component rendering the Hsw Care Plans Screen workspace interface.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class HswCarePlansScreen extends GovernedConsumerWidget {
  const HswCarePlansScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Text(
          'HSW Patient Care Plans',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GovDashboardHero(
              title: 'HSW Patient Care Plans',
              roleName: 'HSW Module',
              description: 'Access and review personalized patient care plans, dietary outlines, and medication support trackers.',
              onRefresh: () {},
            ),
            const SizedBox(height: 24),
            // HSW Dietary Guidelines Viewer component
            Container(
              key: const ValueKey('data-cy-hsw-dietary-guidelines-viewer'),
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
                  Text("Dietary Guidelines & Restrictions", style: theme.typography.h4),
                  const SizedBox(height: 12),
                  Text("Dietary details sandbox viewer.", style: theme.typography.bodyMedium),
                ],
              ),
            ),
            // HSW Mobility Aids Panel component
            Container(
              key: const ValueKey('data-cy-hsw-mobility-aids-panel'),
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
                  Text("Mobility Aids & Transfer Details", style: theme.typography.h4),
                  const SizedBox(height: 12),
                  Text("Mobility support instructions.", style: theme.typography.bodyMedium),
                ],
              ),
            ),
            // HSW Medication Checklist Widget component
            Container(
              key: const ValueKey('data-cy-hsw-medication-checklist-widget'),
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
                  Text("Medication Reminders & Checklist", style: theme.typography.h4),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    key: const ValueKey('sign_off_care_plan_review'),
                    onPressed: () {},
                    icon: const Icon(LucideIcons.checkSquare),
                    label: const Text('Sign-Off Care Plan Pre-Review'),
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
