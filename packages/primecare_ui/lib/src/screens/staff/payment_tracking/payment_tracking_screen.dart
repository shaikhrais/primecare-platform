import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'payment_tracking_screen_controller.dart';
import 'sections/payment_tracking_header_section.dart';
import 'sections/payment_tracking_content_summary_section.dart';
import 'sections/payment_tracking_primary_content_section.dart';
import 'sections/payment_tracking_action_bar_section.dart';


class PaymentTrackingScreen extends ConsumerWidget {
  const PaymentTrackingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(payment_trackingControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('PaymentTracking'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(payment_trackingControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('payment_tracking_loading'), child: Semantics(label: 'payment_tracking_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('payment_tracking_screen'),
                    child: Column(
                      children: [
                        PaymentTrackingHeaderSection(data: state.data),
                        PaymentTrackingContentSummarySection(data: state.data),
                        PaymentTrackingPrimaryContentSection(data: state.data),
                        PaymentTrackingActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
