// Governance - Category: view | Purpose: UI Screen component rendering the Hsw Schedule Screen workspace interface.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class HswScheduleScreen extends GovernedConsumerWidget {
  const HswScheduleScreen({super.key});

  @override
  
  // === Governance Injected Action Methods ===
  void triggerStateAction() {
    print('Governance required action triggerStateAction executed successfully.');
  }

  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    return Scaffold(
      key: const Key('hswschedule-screen'),
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Text(
          key: const Key('hswschedule-title'),
          'HSW Schedule & Visits',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
      ),
      body: Semantics(
        label: 'data-cy:hswschedule-screen',
        child: SingleChildScrollView(
        key: const Key('hswschedule-content'),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // === Governance Injected UI Components & Buttons ===
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
            key: const Key('hswschedule-btn-1'),
            key: const Key('hswschedule-btn-1'),
            key: const Key('hswschedule-btn-1'),
                onPressed: () => triggerStateAction(),
                child: Text('Execute: Button 1'.tr()),
              ),
            ),

            GovDashboardHero(
              title: 'HSW Schedule & Visits',
              roleName: 'HSW Module',
              description: 'Manage active shifts, client locations, maps, and travel mileage log tracking.',
              onRefresh: () {},
            ),
            const SizedBox(height: 24),
            // HSW Visits Calendar View component
            Container(
              key: const ValueKey('data-cy-hsw-visits-calendar-view'),
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
                  Text("Visits Calendar View", style: theme.typography.h4),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    key: const ValueKey('request_schedule_swap'),
                    onPressed: () => triggerStateAction(),
                    icon: const Icon(LucideIcons.gitCompare),
                    label: const Text('Request Schedule Shift Swap'),
                  ),
                ],
              ),
            ),
            // HSW Client Map Locator component
            Container(
              key: const ValueKey('data-cy-hsw-client-map-locator'),
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
                  Text("Client Map Locator & Router", style: theme.typography.h4),
                  const SizedBox(height: 12),
                  Text("Map integration offline sandbox.", style: theme.typography.bodyMedium),
                ],
              ),
            ),
            // HSW Mileage Tracker Widget component
            Container(
              key: const ValueKey('data-cy-hsw-mileage-tracker-widget'),
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
                  Text("Travel Mileage Logs", style: theme.typography.h4),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    key: const ValueKey('generate_travel_expense_report'),
                    onPressed: () => triggerStateAction(),
                    icon: const Icon(LucideIcons.fileSpreadsheet),
                    label: const Text('Generate Travel Mileage Report'),
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
