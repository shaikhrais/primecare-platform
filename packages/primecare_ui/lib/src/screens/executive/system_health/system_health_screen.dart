import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'system_health_screen_controller.dart';
import 'sections/system_health_header_section.dart';
import 'sections/system_health_content_summary_section.dart';
import 'sections/system_health_primary_content_section.dart';
import 'sections/system_health_action_bar_section.dart';


class SystemHealthScreen extends ConsumerWidget {
  const SystemHealthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(system_healthControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('SystemHealth'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(system_healthControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('system_health_loading'), child: Semantics(label: 'system_health_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('system_health_screen'),
                    child: Column(
                      children: [
                        SystemHealthHeaderSection(data: state.data),
                        SystemHealthContentSummarySection(data: state.data),
                        SystemHealthPrimaryContentSection(data: state.data),
                        SystemHealthActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
