import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'enterprise_command_center4_k_screen_controller.dart';
import 'sections/enterprise_command_center4_k_header_section.dart';
import 'sections/enterprise_command_center4_k_content_summary_section.dart';
import 'sections/enterprise_command_center4_k_primary_content_section.dart';
import 'sections/enterprise_command_center4_k_action_bar_section.dart';


class EnterpriseCommandCenter4KScreen extends ConsumerWidget {
  const EnterpriseCommandCenter4KScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(enterprise_command_center4_kControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('EnterpriseCommandCenter4K'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(enterprise_command_center4_kControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('enterprise_command_center4_k_loading'), child: Semantics(label: 'enterprise_command_center4_k_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('enterprise_command_center4_k_screen'),
                    child: Column(
                      children: [
                        EnterpriseCommandCenter4KHeaderSection(data: state.data),
                        EnterpriseCommandCenter4KContentSummarySection(data: state.data),
                        EnterpriseCommandCenter4KPrimaryContentSection(data: state.data),
                        EnterpriseCommandCenter4KActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
