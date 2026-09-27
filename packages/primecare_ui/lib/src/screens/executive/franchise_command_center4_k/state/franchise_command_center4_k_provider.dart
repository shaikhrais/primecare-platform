import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/franchise_command_center4_k_model.dart';

class FranchiseCommandCenter4KNotifier extends StateNotifier<FranchiseCommandCenter4KModel> {
  FranchiseCommandCenter4KNotifier() : super(const FranchiseCommandCenter4KModel(isLoading: true));

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

final franchise_command_center4_kProvider = StateNotifierProvider<FranchiseCommandCenter4KNotifier, FranchiseCommandCenter4KModel>((ref) {
  return FranchiseCommandCenter4KNotifier()..loadData();
});
