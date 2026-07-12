import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'file_verification_dashboard_screen_controller.dart';
import 'sections/file_verification_dashboard_header_section.dart';
import 'sections/file_verification_dashboard_summary_cards_section.dart';
import 'sections/file_verification_dashboard_chart_overview_section.dart';
import 'sections/file_verification_dashboard_recent_activity_section.dart';
import 'sections/file_verification_dashboard_quick_actions_section.dart';


class FileVerificationDashboardScreen extends ConsumerWidget {
  const FileVerificationDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(file_verification_dashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('FileVerificationDashboard'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(file_verification_dashboardControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('file_verification_dashboard_loading'), child: Semantics(label: 'file_verification_dashboard_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('file_verification_dashboard_screen'),
                    child: Column(
                      children: [
                        FileVerificationDashboardHeaderSection(data: state.data),
                        FileVerificationDashboardSummaryCardsSection(data: state.data),
                        FileVerificationDashboardChartOverviewSection(data: state.data),
                        FileVerificationDashboardRecentActivitySection(data: state.data),
                        FileVerificationDashboardQuickActionsSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
