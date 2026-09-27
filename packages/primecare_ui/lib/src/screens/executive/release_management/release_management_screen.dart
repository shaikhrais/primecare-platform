import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'release_management_screen_controller.dart';
import 'sections/release_management_header_section.dart';
import 'sections/release_management_content_summary_section.dart';
import 'sections/release_management_primary_content_section.dart';
import 'sections/release_management_action_bar_section.dart';


class ReleaseManagementScreen extends ConsumerWidget {
  const ReleaseManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(release_managementControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ReleaseManagement'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(release_managementControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('release_management_loading'), child: Semantics(label: 'release_management_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('release_management_screen'),
                    child: Column(
                      children: [
                        ReleaseManagementHeaderSection(data: state.data),
                        ReleaseManagementContentSummarySection(data: state.data),
                        ReleaseManagementPrimaryContentSection(data: state.data),
                        ReleaseManagementActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
