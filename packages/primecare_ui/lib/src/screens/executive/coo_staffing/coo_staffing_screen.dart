import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'coo_staffing_screen_controller.dart';
import 'sections/coo_staffing_header_section.dart';
import 'sections/coo_staffing_content_summary_section.dart';
import 'sections/coo_staffing_primary_content_section.dart';
import 'sections/coo_staffing_action_bar_section.dart';


class CooStaffingScreen extends ConsumerWidget {
  const CooStaffingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(coo_staffingControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CooStaffing'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(coo_staffingControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('coo_staffing_loading'), child: Semantics(label: 'coo_staffing_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('coo_staffing_screen'),
                    child: Column(
                      children: [
                        CooStaffingHeaderSection(data: state.data),
                        CooStaffingContentSummarySection(data: state.data),
                        CooStaffingPrimaryContentSection(data: state.data),
                        CooStaffingActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
