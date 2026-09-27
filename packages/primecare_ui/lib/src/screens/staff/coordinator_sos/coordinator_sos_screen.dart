import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'coordinator_sos_screen_controller.dart';
import 'sections/coordinator_sos_header_section.dart';
import 'sections/coordinator_sos_content_summary_section.dart';
import 'sections/coordinator_sos_primary_content_section.dart';
import 'sections/coordinator_sos_action_bar_section.dart';


class CoordinatorSosScreen extends ConsumerWidget {
  const CoordinatorSosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(coordinator_sosControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CoordinatorSos'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(coordinator_sosControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('coordinator_sos_loading'), child: Semantics(label: 'coordinator_sos_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('coordinator_sos_screen'),
                    child: Column(
                      children: [
                        CoordinatorSosHeaderSection(data: state.data),
                        CoordinatorSosContentSummarySection(data: state.data),
                        CoordinatorSosPrimaryContentSection(data: state.data),
                        CoordinatorSosActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
