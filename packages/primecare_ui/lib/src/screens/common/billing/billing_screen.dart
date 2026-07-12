import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'billing_screen_controller.dart';
import 'sections/billing_header_section.dart';
import 'sections/billing_content_summary_section.dart';
import 'sections/billing_primary_content_section.dart';
import 'sections/billing_action_bar_section.dart';


class BillingScreen extends ConsumerWidget {
  const BillingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(billingControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('Billing'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(billingControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('billing_loading'), child: Semantics(label: 'billing_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('billing_screen'),
                    child: Column(
                      children: [
                        BillingHeaderSection(data: state.data),
                        BillingContentSummarySection(data: state.data),
                        BillingPrimaryContentSection(data: state.data),
                        BillingActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
