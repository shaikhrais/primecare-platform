import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'chiropractor_command_center_screen_controller.dart';
import 'sections/chiropractor_command_center_header_section.dart';
import 'sections/chiropractor_command_center_content_summary_section.dart';
import 'sections/chiropractor_command_center_primary_content_section.dart';
import 'sections/chiropractor_command_center_action_bar_section.dart';


class ChiropractorCommandCenterScreen extends ConsumerWidget {
  const ChiropractorCommandCenterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chiropractor_command_centerControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ChiropractorCommandCenter'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(chiropractor_command_centerControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('chiropractor_command_center_loading'), child: Semantics(label: 'chiropractor_command_center_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('chiropractor_command_center_screen'),
                    child: Column(
                      children: [
                        ChiropractorCommandCenterHeaderSection(data: state.data),
                        ChiropractorCommandCenterContentSummarySection(data: state.data),
                        ChiropractorCommandCenterPrimaryContentSection(data: state.data),
                        ChiropractorCommandCenterActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
