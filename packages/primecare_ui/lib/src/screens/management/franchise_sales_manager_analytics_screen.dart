// Governance - Category: view | Purpose: UI Screen component rendering the Franchise Sales Manager Analytics Screen workspace interface.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class FranchiseSalesManagerAnalyticsScreen extends GovernedConsumerWidget {
  const FranchiseSalesManagerAnalyticsScreen({super.key});

  // === Governance Injected Action Methods ===
  void triggerStateAction() {
    print(
      'Governance required action triggerStateAction executed successfully.',
    );
  }

  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    return Semantics(
      label: 'data-cy:franchisesalesmanageranalytics-screen',
      container: true,
      child: Scaffold(
        key: const Key('franchisesalesmanageranalytics-screen'),
        backgroundColor: theme.colors.background,
        appBar: AppBar(
          backgroundColor: theme.colors.surface,
          elevation: 0,
          title: Text(
            key: const Key('franchisesalesmanageranalytics-title'),
            'FranchiseSalesManager Analytics',
            style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
          ),
        ),
        body: Semantics(
          label: 'data-cy:franchisesalesmanageranalytics-content',
          container: true,
          child: SingleChildScrollView(
            key: const Key('franchisesalesmanageranalytics-content'),
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // === Governance Injected UI Components & Buttons ===
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    key: const Key('franchisesalesmanageranalytics-btn-1'),
                    onPressed: () => triggerStateAction(),
                    child: Text('Execute: Button 1'.tr()),
                  ),
                ),

                Semantics(
                  label: 'data-cy:franchisesalesmanageranalytics-title',
                  child: GovDashboardHero(
                    title: 'FranchiseSalesManager Analytics',
                    roleName: 'FranchiseSalesManager Module',
                    description:
                        'Centralized Analytics operations for FranchiseSalesManager.',
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
                          'Integration Sandbox for FranchiseSalesManager Analytics Module',
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
                          key: const Key(
                            'franchisesalesmanageranalytics-btn-2',
                          ),
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
