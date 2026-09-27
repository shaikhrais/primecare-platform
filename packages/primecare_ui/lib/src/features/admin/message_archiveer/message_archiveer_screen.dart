import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/message_archiveer_header_section.dart';
import 'sections/message_archiveer_content_summary_section.dart';
import 'sections/message_archiveer_primary_content_section.dart';
import 'sections/message_archiveer_action_bar_section.dart';

class MessageArchiveerScreen extends StatelessWidget {
  const MessageArchiveerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'message_archiveer',
      title: 'Message Archiveer',
      child: Column(
        children: const [
          const MessageArchiveerHeaderSection(),
          const MessageArchiveerContentSummarySection(),
          const MessageArchiveerPrimaryContentSection(),
          const MessageArchiveerActionBarSection(),
        ],
      ),
    );
  }
}
