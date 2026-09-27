import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/partnership_management_model.dart';

class PartnershipManagementNotifier extends StateNotifier<PartnershipManagementModel> {
  PartnershipManagementNotifier() : super(const PartnershipManagementModel(isLoading: true));

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

final partnership_managementProvider = StateNotifierProvider<PartnershipManagementNotifier, PartnershipManagementModel>((ref) {
  return PartnershipManagementNotifier()..loadData();
});
