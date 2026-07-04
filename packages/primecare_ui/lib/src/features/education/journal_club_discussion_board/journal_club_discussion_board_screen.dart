import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/journal_club_discussion_board_header_section.dart';
import 'sections/journal_club_discussion_board_content_summary_section.dart';
import 'sections/journal_club_discussion_board_primary_content_section.dart';
import 'sections/journal_club_discussion_board_action_bar_section.dart';

class JournalClubDiscussionBoardScreen extends StatelessWidget {
  const JournalClubDiscussionBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'journal_club_discussion_board',
      title: 'Journal Club Discussion Board',
      child: Column(
        children: const [
          const JournalClubDiscussionBoardHeaderSection(),
          const JournalClubDiscussionBoardContentSummarySection(),
          const JournalClubDiscussionBoardPrimaryContentSection(),
          const JournalClubDiscussionBoardActionBarSection(),
        ],
      ),
    );
  }
}
