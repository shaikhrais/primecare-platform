import 'package:primecare_models/primecare_models.dart';

class PeerReviewConferenceRoomModel extends BaseScreenState<PeerReviewConferenceRoomModel> {
  const PeerReviewConferenceRoomModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PeerReviewConferenceRoomModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PeerReviewConferenceRoomModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
