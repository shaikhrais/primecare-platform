import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'social_media_screen_controller.dart';
import 'sections/social_media_header_section.dart';
import 'sections/social_media_content_summary_section.dart';
import 'sections/social_media_primary_content_section.dart';
import 'sections/social_media_action_bar_section.dart';


class SocialMediaScreen extends ConsumerWidget {
  const SocialMediaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(social_mediaControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('SocialMedia'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(social_mediaControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('social_media_loading'), child: Semantics(label: 'social_media_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('social_media_screen'),
                    child: Column(
                      children: [
                        SocialMediaHeaderSection(data: state.data),
                        SocialMediaContentSummarySection(data: state.data),
                        SocialMediaPrimaryContentSection(data: state.data),
                        SocialMediaActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
