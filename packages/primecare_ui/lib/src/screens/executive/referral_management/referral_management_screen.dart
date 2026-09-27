import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'referral_management_screen_controller.dart';
import 'sections/referral_management_header_section.dart';
import 'sections/referral_management_content_summary_section.dart';
import 'sections/referral_management_primary_content_section.dart';
import 'sections/referral_management_action_bar_section.dart';


class ReferralManagementScreen extends ConsumerWidget {
  const ReferralManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(referral_managementControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ReferralManagement'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(referral_managementControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('referral_management_loading'), child: Semantics(label: 'referral_management_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('referral_management_screen'),
                    child: Column(
                      children: [
                        ReferralManagementHeaderSection(data: state.data),
                        ReferralManagementContentSummarySection(data: state.data),
                        ReferralManagementPrimaryContentSection(data: state.data),
                        ReferralManagementActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
