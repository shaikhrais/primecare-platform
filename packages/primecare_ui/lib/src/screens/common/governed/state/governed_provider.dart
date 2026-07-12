import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/governed_model.dart';

class GovernedNotifier extends StateNotifier<GovernedModel> {
  GovernedNotifier() : super(const GovernedModel(isLoading: true));

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

final governedProvider = StateNotifierProvider<GovernedNotifier, GovernedModel>((ref) {
  return GovernedNotifier()..loadData();
});
