import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'cfo_expenses_screen_controller.dart';
import 'sections/cfo_expenses_header_section.dart';
import 'sections/cfo_expenses_content_summary_section.dart';
import 'sections/cfo_expenses_primary_content_section.dart';
import 'sections/cfo_expenses_action_bar_section.dart';


class CfoExpensesScreen extends ConsumerWidget {
  const CfoExpensesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cfo_expensesControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CfoExpenses'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(cfo_expensesControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('cfo_expenses_loading'), child: Semantics(label: 'cfo_expenses_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('cfo_expenses_screen'),
                    child: Column(
                      children: [
                        CfoExpensesHeaderSection(data: state.data),
                        CfoExpensesContentSummarySection(data: state.data),
                        CfoExpensesPrimaryContentSection(data: state.data),
                        CfoExpensesActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
