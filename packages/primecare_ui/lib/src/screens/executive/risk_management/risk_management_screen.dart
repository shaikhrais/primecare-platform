import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'risk_management_screen_controller.dart';
import 'sections/risk_management_header_section.dart';
import 'sections/risk_management_content_summary_section.dart';
import 'sections/risk_management_primary_content_section.dart';
import 'sections/risk_management_action_bar_section.dart';


class RiskManagementScreen extends ConsumerWidget {
  const RiskManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(risk_managementControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('RiskManagement'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(risk_managementControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('risk_management_loading'), child: Semantics(label: 'risk_management_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('risk_management_screen'),
                    child: Column(
                      children: [
                        RiskManagementHeaderSection(data: state.data),
                        RiskManagementContentSummarySection(data: state.data),
                        RiskManagementPrimaryContentSection(data: state.data),
                        RiskManagementActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
