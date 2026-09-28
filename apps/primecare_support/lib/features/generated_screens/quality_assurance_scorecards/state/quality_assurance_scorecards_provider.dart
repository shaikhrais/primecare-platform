import 'package:flutter_riverpod/legacy.dart';
import '../models/quality_assurance_scorecards_model.dart';

class QualityAssuranceScorecardsNotifier extends StateNotifier<QualityAssuranceScorecardsModel> {
  QualityAssuranceScorecardsNotifier() : super(const QualityAssuranceScorecardsModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const <String, dynamic>{});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final quality_assurance_scorecardsProvider = StateNotifierProvider<QualityAssuranceScorecardsNotifier, QualityAssuranceScorecardsModel>((ref) {
  return QualityAssuranceScorecardsNotifier()..loadData();
});
