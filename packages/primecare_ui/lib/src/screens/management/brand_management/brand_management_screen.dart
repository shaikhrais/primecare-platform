import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'brand_management_screen_controller.dart';
import 'sections/brand_management_header_section.dart';
import 'sections/brand_management_content_summary_section.dart';
import 'sections/brand_management_primary_content_section.dart';
import 'sections/brand_management_action_bar_section.dart';


class BrandManagementScreen extends ConsumerWidget {
  const BrandManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(brand_managementControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('BrandManagement'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(brand_managementControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('brand_management_loading'), child: Semantics(label: 'brand_management_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('brand_management_screen'),
                    child: Column(
                      children: [
                        BrandManagementHeaderSection(data: state.data),
                        BrandManagementContentSummarySection(data: state.data),
                        BrandManagementPrimaryContentSection(data: state.data),
                        BrandManagementActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
