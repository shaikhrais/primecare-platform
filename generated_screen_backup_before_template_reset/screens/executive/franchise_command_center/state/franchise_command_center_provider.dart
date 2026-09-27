import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/franchise_command_center_model.dart';

class FranchiseCommandCenterNotifier extends StateNotifier<FranchiseCommandCenterModel> {
  FranchiseCommandCenterNotifier() : super(const FranchiseCommandCenterModel(isLoading: true));

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

final franchise_command_centerProvider = StateNotifierProvider<FranchiseCommandCenterNotifier, FranchiseCommandCenterModel>((ref) {
  return FranchiseCommandCenterNotifier()..loadData();
});
