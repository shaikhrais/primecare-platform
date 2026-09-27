import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/franchise_owner_staff_model.dart';

class FranchiseOwnerStaffNotifier extends StateNotifier<FranchiseOwnerStaffModel> {
  FranchiseOwnerStaffNotifier() : super(const FranchiseOwnerStaffModel(isLoading: true));

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

final franchise_owner_staffProvider = StateNotifierProvider<FranchiseOwnerStaffNotifier, FranchiseOwnerStaffModel>((ref) {
  return FranchiseOwnerStaffNotifier()..loadData();
});
