// Governance - Category: view | Purpose: Coordinator layout for Journal Club Discussion Board
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JournalClubDiscussionBoardScreen extends ConsumerWidget {
  const JournalClubDiscussionBoardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Journal Club Discussion Board Coordinator'),
      ),
    );
  }
}
