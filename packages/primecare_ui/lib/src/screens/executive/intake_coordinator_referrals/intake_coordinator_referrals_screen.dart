import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'intake_coordinator_referrals_screen_controller.dart';
import 'sections/intake_coordinator_referrals_header_section.dart';
import 'sections/intake_coordinator_referrals_content_summary_section.dart';
import 'sections/intake_coordinator_referrals_primary_content_section.dart';
import 'sections/intake_coordinator_referrals_action_bar_section.dart';


class IntakeCoordinatorReferralsScreen extends ConsumerWidget {
  const IntakeCoordinatorReferralsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(intake_coordinator_referralsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('IntakeCoordinatorReferrals'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(intake_coordinator_referralsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('intake_coordinator_referrals_loading'), child: Semantics(label: 'intake_coordinator_referrals_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('intake_coordinator_referrals_screen'),
                    child: Column(
                      children: [
                        IntakeCoordinatorReferralsHeaderSection(data: state.data),
                        IntakeCoordinatorReferralsContentSummarySection(data: state.data),
                        IntakeCoordinatorReferralsPrimaryContentSection(data: state.data),
                        IntakeCoordinatorReferralsActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
