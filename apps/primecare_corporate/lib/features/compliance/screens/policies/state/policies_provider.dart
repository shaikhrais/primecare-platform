import 'package:flutter_riverpod/legacy.dart';
import '../models/policies_model.dart';

class PoliciesNotifier extends StateNotifier<PoliciesModel> {
  PoliciesNotifier() : super(const PoliciesModel(isLoading: true));

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

final policiesProvider = StateNotifierProvider<PoliciesNotifier, PoliciesModel>((ref) {
  return PoliciesNotifier()..loadData();
});
