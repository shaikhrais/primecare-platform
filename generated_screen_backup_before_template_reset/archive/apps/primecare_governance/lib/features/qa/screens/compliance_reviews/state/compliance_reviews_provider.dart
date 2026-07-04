import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/compliance_reviews_model.dart';

class ComplianceReviewsNotifier extends StateNotifier<ComplianceReviewsModel> {
  ComplianceReviewsNotifier() : super(const ComplianceReviewsModel(isLoading: true));

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

final compliance_reviewsProvider = StateNotifierProvider<ComplianceReviewsNotifier, ComplianceReviewsModel>((ref) {
  return ComplianceReviewsNotifier()..loadData();
});
