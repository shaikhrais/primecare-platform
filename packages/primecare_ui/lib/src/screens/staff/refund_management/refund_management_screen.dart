import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'refund_management_screen_controller.dart';
import 'sections/refund_management_header_section.dart';
import 'sections/refund_management_content_summary_section.dart';
import 'sections/refund_management_primary_content_section.dart';
import 'sections/refund_management_action_bar_section.dart';


class RefundManagementScreen extends ConsumerWidget {
  const RefundManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(refund_managementControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('RefundManagement'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(refund_managementControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('refund_management_loading'), child: Semantics(label: 'refund_management_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('refund_management_screen'),
                    child: Column(
                      children: [
                        RefundManagementHeaderSection(data: state.data),
                        RefundManagementContentSummarySection(data: state.data),
                        RefundManagementPrimaryContentSection(data: state.data),
                        RefundManagementActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
