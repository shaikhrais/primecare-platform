import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/surgical_video_archive_header_section.dart';
import 'sections/surgical_video_archive_content_summary_section.dart';
import 'sections/surgical_video_archive_primary_content_section.dart';
import 'sections/surgical_video_archive_action_bar_section.dart';

class SurgicalVideoArchiveScreen extends StatelessWidget {
  const SurgicalVideoArchiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'surgical_video_archive',
      title: 'Surgical Video Archive',
      child: Column(
        children: const [
          const SurgicalVideoArchiveHeaderSection(),
          const SurgicalVideoArchiveContentSummarySection(),
          const SurgicalVideoArchivePrimaryContentSection(),
          const SurgicalVideoArchiveActionBarSection(),
        ],
      ),
    );
  }
}
