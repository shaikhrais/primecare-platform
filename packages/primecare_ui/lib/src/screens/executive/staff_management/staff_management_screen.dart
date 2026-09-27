import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'staff_management_screen_controller.dart';
import 'sections/staff_management_header_section.dart';
import 'sections/staff_management_content_summary_section.dart';
import 'sections/staff_management_primary_content_section.dart';
import 'sections/staff_management_action_bar_section.dart';


class StaffManagementScreen extends ConsumerWidget {
  const StaffManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(staff_managementControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('StaffManagement'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(staff_managementControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('staff_management_loading'), child: Semantics(label: 'staff_management_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('staff_management_screen'),
                    child: Column(
                      children: [
                        StaffManagementHeaderSection(data: state.data),
                        StaffManagementContentSummarySection(data: state.data),
                        StaffManagementPrimaryContentSection(data: state.data),
                        StaffManagementActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
