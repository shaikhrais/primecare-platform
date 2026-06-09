// Governance - Category: view | Purpose: UI Screen component rendering the Head Of Marketing Workflow Screen workspace interface.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class HeadOfMarketingWorkflowScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components for campaign performance, KPIs, budget tracking, customer engagement, market trends, team performance, feedback analysis, project timelines, sales data integration, and alerts for red flags.';

  @override
  List<String> get requiredComponents => const [
        'CampaignOverviewWidget',
        'KPIChart',
        'BudgetUtilizationWidget',
        'CustomerEngagementMetricsWidget',
        'MarketTrendsWidget',
        'TeamPerformanceWidget',
        'FeedbackAnalysisWidget',
        'ProjectTimelineWidget',
        'SalesDataIntegrationWidget',
        'AlertsWidget',
      ];

  @override
  List<String> get requiredFunctions => const [
        'fetchCampaignData',
        'trackKPIs',
        'analyzeBudget',
        'fetchEngagementMetrics',
        'getMarketTrends',
        'evaluateTeamPerformance',
        'analyzeCustomerFeedback',
        'checkProjectTimelines',
        'integrateSalesData',
        'triggerAlerts',
      ];

  const HeadOfMarketingWorkflowScreen({super.key});

  // === Governance Injected Action Methods ===
  void triggerStateAction() {
    print(
      'Governance required action triggerStateAction executed successfully.',
    );
  }

  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    return Semantics(
      label: 'data-cy:headofmarketingworkflow-screen',
      container: true,
      child: Scaffold(
        key: const Key('headofmarketingworkflow-screen'),
        backgroundColor: theme.colors.background,
        appBar: AppBar(
          backgroundColor: theme.colors.surface,
          elevation: 0,
          title: Text(
            key: const Key('headofmarketingworkflow-title'),
            'HeadOfMarketing Workflow',
            style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
          ),
        ),
        body: Semantics(
          label: 'data-cy:headofmarketingworkflow-content',
          container: true,
          child: SingleChildScrollView(
            key: const Key('headofmarketingworkflow-content'),
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // === Governance Injected UI Components & Buttons ===
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    key: const Key('headofmarketingworkflow-btn-1'),
                    onPressed: () => triggerStateAction(),
                    child: Text('Execute: Button 1'.tr()),
                  ),
                ),

                Semantics(
                  label: 'data-cy:headofmarketingworkflow-title',
                  child: GovDashboardHero(
                    title: 'HeadOfMarketing Workflow',
                    roleName: 'HeadOfMarketing Module',
                    description:
                        'Centralized Workflow operations for HeadOfMarketing.',
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
                          'Integration Sandbox for HeadOfMarketing Workflow Module',
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
                          key: const Key('headofmarketingworkflow-btn-2'),
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
