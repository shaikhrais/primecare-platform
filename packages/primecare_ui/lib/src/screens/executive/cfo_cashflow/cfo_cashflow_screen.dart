import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'cfo_cashflow_screen_controller.dart';
import 'sections/cfo_cashflow_header_section.dart';
import 'sections/cfo_cashflow_content_summary_section.dart';
import 'sections/cfo_cashflow_primary_content_section.dart';
import 'sections/cfo_cashflow_action_bar_section.dart';


class CfoCashflowScreen extends ConsumerWidget {
  const CfoCashflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cfo_cashflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CfoCashflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(cfo_cashflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('cfo_cashflow_loading'), child: Semantics(label: 'cfo_cashflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('cfo_cashflow_screen'),
                    child: Column(
                      children: [
                        CfoCashflowHeaderSection(data: state.data),
                        CfoCashflowContentSummarySection(data: state.data),
                        CfoCashflowPrimaryContentSection(data: state.data),
                        CfoCashflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
