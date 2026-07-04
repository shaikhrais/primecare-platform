import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/franchise_lead_model.dart';

class FranchiseLeadNotifier extends StateNotifier<FranchiseLeadModel> {
  FranchiseLeadNotifier() : super(const FranchiseLeadModel(isLoading: true));

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

final franchise_leadProvider = StateNotifierProvider<FranchiseLeadNotifier, FranchiseLeadModel>((ref) {
  return FranchiseLeadNotifier()..loadData();
});
