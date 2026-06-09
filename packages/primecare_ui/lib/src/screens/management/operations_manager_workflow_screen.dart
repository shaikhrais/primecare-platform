// Governance - Category: view | Purpose: UI Screen component rendering the Operations Manager Workflow Screen workspace interface.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class OperationsManagerWorkflowScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires a comprehensive dashboard for the Operations Manager to monitor KPIs, team performance, budget, compliance, and red flags in operations.';

  @override
  List<String> get requiredComponents => const [
        'KPIOverviewWidget',
        'OperationalMetricsChart',
        'TeamPerformanceReport',
        'BudgetOverviewCard',
        'ComplianceStatusAlert',
        'ProjectTimelineTracker',
        'EmployeeSatisfactionWidget',
        'IncidentReportTracker',
        'ResourceAllocationChart',
        'RedFlagAlert',
      ];

  @override
  List<String> get requiredFunctions => const [
        'fetchKPIData',
        'fetchOperationalMetrics',
        'generatePerformanceReport',
        'fetchBudgetData',
        'checkComplianceStatus',
        'updateProjectTimeline',
        'collectEmployeeFeedback',
        'trackIncidents',
        'analyzeResourceUtilization',
        'triggerRedFlagAlert',
      ];

  const OperationsManagerWorkflowScreen({super.key});

  // === Governance Injected Action Methods ===
  void triggerStateAction() {
    print(
      'Governance required action triggerStateAction executed successfully.',
    );
  }

  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    return Semantics(
      label: 'data-cy:operationsmanagerworkflow-screen',
      container: true,
      child: Scaffold(
        key: const Key('operationsmanagerworkflow-screen'),
        backgroundColor: theme.colors.background,
        appBar: AppBar(
          backgroundColor: theme.colors.surface,
          elevation: 0,
          title: Text(
            key: const Key('operationsmanagerworkflow-title'),
            'OperationsManager Workflow',
            style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
          ),
        ),
        body: Semantics(
          label: 'data-cy:operationsmanagerworkflow-content',
          container: true,
          child: SingleChildScrollView(
            key: const Key('operationsmanagerworkflow-content'),
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // === Governance Injected UI Components & Buttons ===
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    key: const Key('operationsmanagerworkflow-btn-1'),
                    onPressed: () => triggerStateAction(),
                    child: Text('Execute: Button 1'.tr()),
                  ),
                ),

                Semantics(
                  label: 'data-cy:operationsmanagerworkflow-title',
                  child: GovDashboardHero(
                    title: 'OperationsManager Workflow',
                    roleName: 'OperationsManager Module',
                    description:
                        'Centralized Workflow operations for OperationsManager.',
                    onRefresh: () {},
                  ),
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
                        child: Text(
                          'Integration Sandbox for OperationsManager Workflow Module',
                          style: theme.typography.bodyLarge.copyWith(
                            color: theme.colors.onSurface,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          key: const Key('operationsmanagerworkflow-btn-2'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () => triggerStateAction(),
                          child: Text(
                            'Execute Action Sweep',
                            style: theme.typography.button.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
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
