import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/claims_processing_model.dart';

class ClaimsProcessingNotifier extends StateNotifier<ClaimsProcessingModel> {
  ClaimsProcessingNotifier() : super(const ClaimsProcessingModel(isLoading: true));

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

final claims_processingProvider = StateNotifierProvider<ClaimsProcessingNotifier, ClaimsProcessingModel>((ref) {
  return ClaimsProcessingNotifier()..loadData();
});
