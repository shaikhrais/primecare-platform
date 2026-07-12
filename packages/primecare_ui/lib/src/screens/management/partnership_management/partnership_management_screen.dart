import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'partnership_management_screen_controller.dart';
import 'sections/partnership_management_header_section.dart';
import 'sections/partnership_management_content_summary_section.dart';
import 'sections/partnership_management_primary_content_section.dart';
import 'sections/partnership_management_action_bar_section.dart';


class PartnershipManagementScreen extends ConsumerWidget {
  const PartnershipManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(partnership_managementControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('PartnershipManagement'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(partnership_managementControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('partnership_management_loading'), child: Semantics(label: 'partnership_management_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('partnership_management_screen'),
                    child: Column(
                      children: [
                        PartnershipManagementHeaderSection(data: state.data),
                        PartnershipManagementContentSummarySection(data: state.data),
                        PartnershipManagementPrimaryContentSection(data: state.data),
                        PartnershipManagementActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
