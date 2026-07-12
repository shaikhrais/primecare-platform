import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'open_shift_screen_controller.dart';
import 'sections/open_shift_header_section.dart';
import 'sections/open_shift_content_summary_section.dart';
import 'sections/open_shift_primary_content_section.dart';
import 'sections/open_shift_action_bar_section.dart';


class OpenShiftScreen extends ConsumerWidget {
  const OpenShiftScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(open_shiftControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('OpenShift'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(open_shiftControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('open_shift_loading'), child: Semantics(label: 'open_shift_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('open_shift_screen'),
                    child: Column(
                      children: [
                        OpenShiftHeaderSection(data: state.data),
                        OpenShiftContentSummarySection(data: state.data),
                        OpenShiftPrimaryContentSection(data: state.data),
                        OpenShiftActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
