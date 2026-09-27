import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/conflict_resolution_model.dart';

class ConflictResolutionNotifier extends StateNotifier<ConflictResolutionModel> {
  ConflictResolutionNotifier() : super(const ConflictResolutionModel(isLoading: true));

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

final conflict_resolutionProvider = StateNotifierProvider<ConflictResolutionNotifier, ConflictResolutionModel>((ref) {
  return ConflictResolutionNotifier()..loadData();
});
