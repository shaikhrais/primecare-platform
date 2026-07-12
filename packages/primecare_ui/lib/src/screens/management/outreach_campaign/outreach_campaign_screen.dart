import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'outreach_campaign_screen_controller.dart';
import 'sections/outreach_campaign_header_section.dart';
import 'sections/outreach_campaign_content_summary_section.dart';
import 'sections/outreach_campaign_primary_content_section.dart';
import 'sections/outreach_campaign_action_bar_section.dart';


class OutreachCampaignScreen extends ConsumerWidget {
  const OutreachCampaignScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(outreach_campaignControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('OutreachCampaign'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(outreach_campaignControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('outreach_campaign_loading'), child: Semantics(label: 'outreach_campaign_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('outreach_campaign_screen'),
                    child: Column(
                      children: [
                        OutreachCampaignHeaderSection(data: state.data),
                        OutreachCampaignContentSummarySection(data: state.data),
                        OutreachCampaignPrimaryContentSection(data: state.data),
                        OutreachCampaignActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
