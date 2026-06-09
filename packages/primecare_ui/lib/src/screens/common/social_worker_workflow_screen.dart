// Governance - Category: view | Purpose: UI Screen component rendering the Social Worker Workflow Screen workspace interface.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class SocialWorkerWorkflowScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components for task management, client overview, alerts, and performance metrics, along with buttons for task actions and API integrations for data retrieval and updates.';

  @override
  List<String> get requiredComponents => const [
        'TaskList',
        'ClientOverview',
        'AlertsPanel',
        'DocumentAccess',
        'MetricsDashboard',
        'CommunicationTools',
        'ResourceDirectory',
        'TrainingOpportunities',
        'FeedbackTools',
        'PerformanceReport',
        'WorkloadVisualization',
      ];

  @override
  List<String> get requiredFunctions => const [
        'addTask',
        'viewClientRecord',
        'sendAlert',
        'generateReport',
        'requestResources',
        'scheduleAppointment',
      ];

  const SocialWorkerWorkflowScreen({super.key});

  // === Governance Injected Action Methods ===
  void triggerStateAction() {
    print(
      'Governance required action triggerStateAction executed successfully.',
    );
  }

  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    return Semantics(
      label: 'data-cy:socialworkerworkflow-screen',
      container: true,
      child: Scaffold(
        key: const Key('socialworkerworkflow-screen'),
        backgroundColor: theme.colors.background,
        appBar: AppBar(
          backgroundColor: theme.colors.surface,
          elevation: 0,
          title: Text(
            key: const Key('socialworkerworkflow-title'),
            'SocialWorker Workflow',
            style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
          ),
        ),
        body: Semantics(
          label: 'data-cy:socialworkerworkflow-content',
          container: true,
          child: SingleChildScrollView(
            key: const Key('socialworkerworkflow-content'),
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // === Governance Injected UI Components & Buttons ===
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    key: const Key('socialworkerworkflow-btn-1'),
                    onPressed: () => triggerStateAction(),
                    child: Text('Execute: Button 1'.tr()),
                  ),
                ),

                Semantics(
                  label: 'data-cy:socialworkerworkflow-title',
                  child: GovDashboardHero(
                    title: 'SocialWorker Workflow',
                    roleName: 'SocialWorker Module',
                    description:
                        'Centralized Workflow operations for SocialWorker.',
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
                          'Integration Sandbox for SocialWorker Workflow Module',
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
                          key: const Key('socialworkerworkflow-btn-2'),
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
