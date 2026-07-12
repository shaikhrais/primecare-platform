import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'therapist_dashboard_controller.dart';
import 'sections/therapist_dashboard_header_section.dart';
import 'sections/therapist_dashboard_summary_cards_section.dart';
import 'sections/therapist_dashboard_chart_overview_section.dart';
import 'sections/therapist_dashboard_recent_activity_section.dart';
import 'sections/therapist_dashboard_quick_actions_section.dart';

class TherapistDashboardScreen extends ConsumerWidget {
  const TherapistDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(therapistDashboardControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('Therapist Dashboard'),
          ),
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('therapist_loading'), child: CircularProgressIndicator())
            : SingleChildScrollView(
                key: const Key('therapist_screen'),
                child: Column(
                  children: [
                    TherapistDashboardHeaderSection(),
                    TherapistDashboardSummaryCardsSection(),
                    const TherapistDashboardChartOverviewSection(),
                    const TherapistDashboardRecentActivitySection(),
                    const TherapistDashboardQuickActionsSection(),
                  ],
                ),
              ),
      ),
    );
  }
}
