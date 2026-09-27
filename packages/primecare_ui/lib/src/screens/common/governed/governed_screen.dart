import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'governed_screen_controller.dart';
import 'sections/governed_header_section.dart';
import 'sections/governed_content_summary_section.dart';
import 'sections/governed_primary_content_section.dart';
import 'sections/governed_action_bar_section.dart';


class Governed extends ConsumerWidget {
  const Governed({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(governedControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('Governed'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(governedControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('governed_loading'), child: Semantics(label: 'governed_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('governed_screen'),
                    child: Column(
                      children: [
                        GovernedHeaderSection(data: state.data),
                        GovernedContentSummarySection(data: state.data),
                        GovernedPrimaryContentSection(data: state.data),
                        GovernedActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
