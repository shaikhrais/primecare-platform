import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'offer_management_screen_controller.dart';
import 'sections/offer_management_header_section.dart';
import 'sections/offer_management_content_summary_section.dart';
import 'sections/offer_management_primary_content_section.dart';
import 'sections/offer_management_action_bar_section.dart';


class OfferManagementScreen extends ConsumerWidget {
  const OfferManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(offer_managementControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('OfferManagement'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(offer_managementControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('offer_management_loading'), child: Semantics(label: 'offer_management_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('offer_management_screen'),
                    child: Column(
                      children: [
                        OfferManagementHeaderSection(data: state.data),
                        OfferManagementContentSummarySection(data: state.data),
                        OfferManagementPrimaryContentSection(data: state.data),
                        OfferManagementActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
