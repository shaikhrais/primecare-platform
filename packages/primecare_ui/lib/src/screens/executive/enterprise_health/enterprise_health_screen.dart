import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'enterprise_health_screen_controller.dart';
import 'sections/enterprise_health_header_section.dart';
import 'sections/enterprise_health_content_summary_section.dart';
import 'sections/enterprise_health_primary_content_section.dart';
import 'sections/enterprise_health_action_bar_section.dart';


class EnterpriseHealthScreen extends ConsumerWidget {
  const EnterpriseHealthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(enterprise_healthControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('EnterpriseHealth'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(enterprise_healthControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('enterprise_health_loading'), child: Semantics(label: 'enterprise_health_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('enterprise_health_screen'),
                    child: Column(
                      children: [
                        EnterpriseHealthHeaderSection(data: state.data),
                        EnterpriseHealthContentSummarySection(data: state.data),
                        EnterpriseHealthPrimaryContentSection(data: state.data),
                        EnterpriseHealthActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
