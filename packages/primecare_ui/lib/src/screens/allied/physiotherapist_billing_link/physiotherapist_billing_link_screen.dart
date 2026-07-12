import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'physiotherapist_billing_link_screen_controller.dart';
import 'sections/physiotherapist_billing_link_header_section.dart';
import 'sections/physiotherapist_billing_link_content_summary_section.dart';
import 'sections/physiotherapist_billing_link_primary_content_section.dart';
import 'sections/physiotherapist_billing_link_action_bar_section.dart';


class PhysiotherapistBillingLinkScreen extends ConsumerWidget {
  const PhysiotherapistBillingLinkScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(physiotherapist_billing_linkControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('PhysiotherapistBillingLink'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(physiotherapist_billing_linkControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('physiotherapist_billing_link_loading'), child: Semantics(label: 'physiotherapist_billing_link_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('physiotherapist_billing_link_screen'),
                    child: Column(
                      children: [
                        PhysiotherapistBillingLinkHeaderSection(data: state.data),
                        PhysiotherapistBillingLinkContentSummarySection(data: state.data),
                        PhysiotherapistBillingLinkPrimaryContentSection(data: state.data),
                        PhysiotherapistBillingLinkActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
