import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/franchise_owner_command_center_model.dart';

class FranchiseOwnerCommandCenterNotifier extends StateNotifier<FranchiseOwnerCommandCenterModel> {
  FranchiseOwnerCommandCenterNotifier() : super(const FranchiseOwnerCommandCenterModel(isLoading: true));

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

final franchise_owner_command_centerProvider = StateNotifierProvider<FranchiseOwnerCommandCenterNotifier, FranchiseOwnerCommandCenterModel>((ref) {
  return FranchiseOwnerCommandCenterNotifier()..loadData();
});
