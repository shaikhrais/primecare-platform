import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'chiropractor_billing_link_screen_controller.dart';
import 'sections/chiropractor_billing_link_header_section.dart';
import 'sections/chiropractor_billing_link_content_summary_section.dart';
import 'sections/chiropractor_billing_link_primary_content_section.dart';
import 'sections/chiropractor_billing_link_action_bar_section.dart';


class ChiropractorBillingLinkScreen extends ConsumerWidget {
  const ChiropractorBillingLinkScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chiropractor_billing_linkControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ChiropractorBillingLink'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(chiropractor_billing_linkControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('chiropractor_billing_link_loading'), child: Semantics(label: 'chiropractor_billing_link_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('chiropractor_billing_link_screen'),
                    child: Column(
                      children: [
                        ChiropractorBillingLinkHeaderSection(data: state.data),
                        ChiropractorBillingLinkContentSummarySection(data: state.data),
                        ChiropractorBillingLinkPrimaryContentSection(data: state.data),
                        ChiropractorBillingLinkActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
