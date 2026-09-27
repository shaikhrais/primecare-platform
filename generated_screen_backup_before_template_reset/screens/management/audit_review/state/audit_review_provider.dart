import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/audit_review_model.dart';

class AuditReviewNotifier extends StateNotifier<AuditReviewModel> {
  AuditReviewNotifier() : super(const AuditReviewModel(isLoading: true));

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

final audit_reviewProvider = StateNotifierProvider<AuditReviewNotifier, AuditReviewModel>((ref) {
  return AuditReviewNotifier()..loadData();
});
