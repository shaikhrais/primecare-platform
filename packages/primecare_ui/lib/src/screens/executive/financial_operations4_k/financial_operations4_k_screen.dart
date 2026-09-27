import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'financial_operations4_k_screen_controller.dart';
import 'sections/financial_operations4_k_header_section.dart';
import 'sections/financial_operations4_k_content_summary_section.dart';
import 'sections/financial_operations4_k_primary_content_section.dart';
import 'sections/financial_operations4_k_action_bar_section.dart';


class FinancialOperations4KScreen extends ConsumerWidget {
  const FinancialOperations4KScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(financial_operations4_kControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('FinancialOperations4K'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(financial_operations4_kControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('financial_operations4_k_loading'), child: Semantics(label: 'financial_operations4_k_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('financial_operations4_k_screen'),
                    child: Column(
                      children: [
                        FinancialOperations4KHeaderSection(data: state.data),
                        FinancialOperations4KContentSummarySection(data: state.data),
                        FinancialOperations4KPrimaryContentSection(data: state.data),
                        FinancialOperations4KActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
