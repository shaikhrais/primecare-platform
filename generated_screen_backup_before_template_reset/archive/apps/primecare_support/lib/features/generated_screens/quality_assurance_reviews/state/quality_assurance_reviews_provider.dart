import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/quality_assurance_reviews_model.dart';

class QualityAssuranceReviewsNotifier extends StateNotifier<QualityAssuranceReviewsModel> {
  QualityAssuranceReviewsNotifier() : super(const QualityAssuranceReviewsModel(isLoading: true));

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

final quality_assurance_reviewsProvider = StateNotifierProvider<QualityAssuranceReviewsNotifier, QualityAssuranceReviewsModel>((ref) {
  return QualityAssuranceReviewsNotifier()..loadData();
});
