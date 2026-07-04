import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/peer_review_conference_room_header_section.dart';
import 'sections/peer_review_conference_room_filter_bar_section.dart';
import 'sections/peer_review_conference_room_data_table_section.dart';
import 'sections/peer_review_conference_room_pagination_section.dart';
import 'sections/peer_review_conference_room_action_bar_section.dart';

class PeerReviewConferenceRoomScreen extends StatelessWidget {
  const PeerReviewConferenceRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'peer_review_conference_room',
      title: 'Peer Review Conference Room',
      child: Column(
        children: const [
          const PeerReviewConferenceRoomHeaderSection(),
          const PeerReviewConferenceRoomFilterBarSection(),
          const PeerReviewConferenceRoomDataTableSection(),
          const PeerReviewConferenceRoomPaginationSection(),
          const PeerReviewConferenceRoomActionBarSection(),
        ],
      ),
    );
  }
}
