import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'revenue_screen_controller.dart';
import 'sections/revenue_header_section.dart';
import 'sections/revenue_content_summary_section.dart';
import 'sections/revenue_primary_content_section.dart';
import 'sections/revenue_action_bar_section.dart';


class RevenueScreen extends ConsumerWidget {
  const RevenueScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(revenueControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('Revenue'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(revenueControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('revenue_loading'), child: Semantics(label: 'revenue_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('revenue_screen'),
                    child: Column(
                      children: [
                        RevenueHeaderSection(data: state.data),
                        RevenueContentSummarySection(data: state.data),
                        RevenuePrimaryContentSection(data: state.data),
                        RevenueActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
