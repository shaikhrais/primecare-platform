import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'rmt_billing_link_screen_controller.dart';
import 'sections/rmt_billing_link_header_section.dart';
import 'sections/rmt_billing_link_content_summary_section.dart';
import 'sections/rmt_billing_link_primary_content_section.dart';
import 'sections/rmt_billing_link_action_bar_section.dart';


class RmtBillingLinkScreen extends ConsumerWidget {
  const RmtBillingLinkScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rmt_billing_linkControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('RmtBillingLink'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(rmt_billing_linkControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('rmt_billing_link_loading'), child: Semantics(label: 'rmt_billing_link_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('rmt_billing_link_screen'),
                    child: Column(
                      children: [
                        RmtBillingLinkHeaderSection(data: state.data),
                        RmtBillingLinkContentSummarySection(data: state.data),
                        RmtBillingLinkPrimaryContentSection(data: state.data),
                        RmtBillingLinkActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
