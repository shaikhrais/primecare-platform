import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'default_not_implemented_screen_controller.dart';
import 'sections/default_not_implemented_header_section.dart';
import 'sections/default_not_implemented_content_summary_section.dart';
import 'sections/default_not_implemented_primary_content_section.dart';
import 'sections/default_not_implemented_action_bar_section.dart';


class DefaultNotImplementedScreen extends ConsumerWidget {
  const DefaultNotImplementedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(default_not_implementedControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('Default Not Implemented'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(default_not_implementedControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('default_not_implemented_loading'), child: Semantics(label: 'default_not_implemented_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('default_not_implemented_screen'),
                    child: Column(
                      children: [
                        DefaultNotImplementedHeaderSection(data: state.data),
                        DefaultNotImplementedContentSummarySection(data: state.data),
                        DefaultNotImplementedPrimaryContentSection(data: state.data),
                        DefaultNotImplementedActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
