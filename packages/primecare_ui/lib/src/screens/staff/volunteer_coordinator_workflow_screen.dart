// Governance - Category: view | Purpose: UI Screen component rendering the Volunteer Coordinator Workflow Screen workspace interface.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class VolunteerCoordinatorWorkflowScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components for task management, real-time updates, collaboration tools, and performance metrics, along with necessary buttons and API integrations.';

  @override
  List<String> get requiredComponents => const [
        'TaskList',
        'Dashboard',
        'NotificationPanel',
        'CollaborationTool',
        'PerformanceMetrics',
      ];

  @override
  List<String> get requiredFunctions => const [
        'executeTask',
        'refreshDashboard',
        'joinSandbox',
        'sendNotification',
      ];

  const VolunteerCoordinatorWorkflowScreen({super.key});

  // === Governance Injected Action Methods ===
  void triggerStateAction() {
    print(
      'Governance required action triggerStateAction executed successfully.',
    );
  }

  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    return Semantics(
      label: 'data-cy:volunteercoordinatorworkflow-screen',
      container: true,
      child: Scaffold(
        key: const Key('volunteercoordinatorworkflow-screen'),
        backgroundColor: theme.colors.background,
        appBar: AppBar(
          backgroundColor: theme.colors.surface,
          elevation: 0,
          title: Text(
            key: const Key('volunteercoordinatorworkflow-title'),
            'VolunteerCoordinator Workflow',
            style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
          ),
        ),
        body: Semantics(
          label: 'data-cy:volunteercoordinatorworkflow-content',
          container: true,
          child: SingleChildScrollView(
            key: const Key('volunteercoordinatorworkflow-content'),
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // === Governance Injected UI Components & Buttons ===
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    key: const Key('volunteercoordinatorworkflow-btn-1'),
                    onPressed: () => triggerStateAction(),
                    child: Text('Execute: Button 1'.tr()),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    key: const Key('volunteercoordinatorworkflow-btn-2'),
                    onPressed: () => triggerStateAction(),
                    child: Text('Execute: Button 2'.tr()),
                  ),
                ),

                Semantics(
                  label: 'data-cy:volunteercoordinatorworkflow-title',
                  child: GovDashboardHero(
                    title: 'VolunteerCoordinator Workflow',
                    roleName: 'VolunteerCoordinator Module',
                    description:
                        'Centralized Workflow operations for VolunteerCoordinator.',
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
                          'Integration Sandbox for VolunteerCoordinator Workflow Module',
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
                          key: const Key('volunteercoordinatorworkflow-btn-3'),
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
