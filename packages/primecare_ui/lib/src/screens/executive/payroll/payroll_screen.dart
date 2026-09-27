import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'payroll_screen_controller.dart';
import 'sections/payroll_header_section.dart';
import 'sections/payroll_content_summary_section.dart';
import 'sections/payroll_primary_content_section.dart';
import 'sections/payroll_action_bar_section.dart';


class PayrollScreen extends ConsumerWidget {
  const PayrollScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(payrollControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('Payroll'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(payrollControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('payroll_loading'), child: Semantics(label: 'payroll_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('payroll_screen'),
                    child: Column(
                      children: [
                        PayrollHeaderSection(data: state.data),
                        PayrollContentSummarySection(data: state.data),
                        PayrollPrimaryContentSection(data: state.data),
                        PayrollActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
