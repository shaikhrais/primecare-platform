import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'cfo_revenue_screen_controller.dart';
import 'sections/cfo_revenue_header_section.dart';
import 'sections/cfo_revenue_content_summary_section.dart';
import 'sections/cfo_revenue_primary_content_section.dart';
import 'sections/cfo_revenue_action_bar_section.dart';


class CfoRevenueScreen extends ConsumerWidget {
  const CfoRevenueScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cfo_revenueControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CfoRevenue'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(cfo_revenueControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('cfo_revenue_loading'), child: Semantics(label: 'cfo_revenue_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('cfo_revenue_screen'),
                    child: Column(
                      children: [
                        CfoRevenueHeaderSection(data: state.data),
                        CfoRevenueContentSummarySection(data: state.data),
                        CfoRevenuePrimaryContentSection(data: state.data),
                        CfoRevenueActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
