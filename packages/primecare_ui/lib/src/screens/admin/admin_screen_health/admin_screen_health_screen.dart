import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'admin_screen_health_screen_controller.dart';
import 'sections/admin_screen_health_header_section.dart';
import 'sections/admin_screen_health_content_summary_section.dart';
import 'sections/admin_screen_health_primary_content_section.dart';
import 'sections/admin_screen_health_action_bar_section.dart';


class AdminScreenHealthScreen extends ConsumerWidget {
  const AdminScreenHealthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(admin_screen_healthControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('AdminHealth'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(admin_screen_healthControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('admin_screen_health_loading'), child: Semantics(label: 'admin_screen_health_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('admin_screen_health_screen'),
                    child: Column(
                      children: [
                        AdminScreenHealthHeaderSection(data: state.data),
                        AdminScreenHealthContentSummarySection(data: state.data),
                        AdminScreenHealthPrimaryContentSection(data: state.data),
                        AdminScreenHealthActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
