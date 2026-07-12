import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'hr_hiring_offers_screen_controller.dart';
import 'sections/hr_hiring_offers_header_section.dart';
import 'sections/hr_hiring_offers_content_summary_section.dart';
import 'sections/hr_hiring_offers_primary_content_section.dart';
import 'sections/hr_hiring_offers_action_bar_section.dart';


class HrHiringOffersScreen extends ConsumerWidget {
  const HrHiringOffersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(hr_hiring_offersControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('HrHiringOffers'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(hr_hiring_offersControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('hr_hiring_offers_loading'), child: Semantics(label: 'hr_hiring_offers_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('hr_hiring_offers_screen'),
                    child: Column(
                      children: [
                        HrHiringOffersHeaderSection(data: state.data),
                        HrHiringOffersContentSummarySection(data: state.data),
                        HrHiringOffersPrimaryContentSection(data: state.data),
                        HrHiringOffersActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
