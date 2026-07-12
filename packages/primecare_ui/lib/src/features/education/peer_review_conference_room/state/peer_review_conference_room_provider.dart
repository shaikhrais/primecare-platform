import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/peer_review_conference_room_model.dart';

class PeerReviewConferenceRoomNotifier extends StateNotifier<PeerReviewConferenceRoomModel> {
  PeerReviewConferenceRoomNotifier() : super(const PeerReviewConferenceRoomModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const {});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final peer_review_conference_roomProvider = StateNotifierProvider<PeerReviewConferenceRoomNotifier, PeerReviewConferenceRoomModel>((ref) {
  return PeerReviewConferenceRoomNotifier()..loadData();
});
