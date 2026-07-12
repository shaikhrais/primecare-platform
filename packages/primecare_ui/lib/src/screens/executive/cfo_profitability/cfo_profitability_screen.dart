import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'cfo_profitability_screen_controller.dart';
import 'sections/cfo_profitability_header_section.dart';
import 'sections/cfo_profitability_content_summary_section.dart';
import 'sections/cfo_profitability_primary_content_section.dart';
import 'sections/cfo_profitability_action_bar_section.dart';


class CfoProfitabilityScreen extends ConsumerWidget {
  const CfoProfitabilityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cfo_profitabilityControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CfoProfitability'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(cfo_profitabilityControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('cfo_profitability_loading'), child: Semantics(label: 'cfo_profitability_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('cfo_profitability_screen'),
                    child: Column(
                      children: [
                        CfoProfitabilityHeaderSection(data: state.data),
                        CfoProfitabilityContentSummarySection(data: state.data),
                        CfoProfitabilityPrimaryContentSection(data: state.data),
                        CfoProfitabilityActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
