import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'cfo_payroll_screen_controller.dart';
import 'sections/cfo_payroll_header_section.dart';
import 'sections/cfo_payroll_content_summary_section.dart';
import 'sections/cfo_payroll_primary_content_section.dart';
import 'sections/cfo_payroll_action_bar_section.dart';


class CfoPayrollScreen extends ConsumerWidget {
  const CfoPayrollScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cfo_payrollControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CfoPayroll'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(cfo_payrollControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('cfo_payroll_loading'), child: Semantics(label: 'cfo_payroll_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('cfo_payroll_screen'),
                    child: Column(
                      children: [
                        CfoPayrollHeaderSection(data: state.data),
                        CfoPayrollContentSummarySection(data: state.data),
                        CfoPayrollPrimaryContentSection(data: state.data),
                        CfoPayrollActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
