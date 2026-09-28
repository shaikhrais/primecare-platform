import 'package:flutter_riverpod/legacy.dart';
import '../models/franchise_owner_hiring_model.dart';

class FranchiseOwnerHiringNotifier extends StateNotifier<FranchiseOwnerHiringModel> {
  FranchiseOwnerHiringNotifier() : super(const FranchiseOwnerHiringModel(isLoading: true));

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

final franchise_owner_hiringProvider = StateNotifierProvider<FranchiseOwnerHiringNotifier, FranchiseOwnerHiringModel>((ref) {
  return FranchiseOwnerHiringNotifier()..loadData();
});
