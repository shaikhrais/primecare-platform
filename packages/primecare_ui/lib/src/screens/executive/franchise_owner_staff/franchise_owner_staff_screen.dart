import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'franchise_owner_staff_screen_controller.dart';
import 'sections/franchise_owner_staff_header_section.dart';
import 'sections/franchise_owner_staff_content_summary_section.dart';
import 'sections/franchise_owner_staff_primary_content_section.dart';
import 'sections/franchise_owner_staff_action_bar_section.dart';


class FranchiseOwnerStaffScreen extends ConsumerWidget {
  const FranchiseOwnerStaffScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(franchise_owner_staffControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('FranchiseOwnerStaff'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(franchise_owner_staffControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('franchise_owner_staff_loading'), child: Semantics(label: 'franchise_owner_staff_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('franchise_owner_staff_screen'),
                    child: Column(
                      children: [
                        FranchiseOwnerStaffHeaderSection(data: state.data),
                        FranchiseOwnerStaffContentSummarySection(data: state.data),
                        FranchiseOwnerStaffPrimaryContentSection(data: state.data),
                        FranchiseOwnerStaffActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
