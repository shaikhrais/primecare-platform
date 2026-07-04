import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/social_media_header_section.dart';
import 'sections/social_media_content_summary_section.dart';
import 'sections/social_media_primary_content_section.dart';
import 'sections/social_media_action_bar_section.dart';

class SocialMediaScreen extends StatelessWidget {
  const SocialMediaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'social_media',
      title: 'SocialMediaScreen',
      child: Column(
        children: const [
          const SocialMediaHeaderSection(),
          const SocialMediaContentSummarySection(),
          const SocialMediaPrimaryContentSection(),
          const SocialMediaActionBarSection(),
        ],
      ),
    );
  }
}
