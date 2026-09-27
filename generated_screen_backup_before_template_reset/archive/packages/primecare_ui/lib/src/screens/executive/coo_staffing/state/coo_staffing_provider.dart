import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/coo_staffing_model.dart';

class CooStaffingNotifier extends StateNotifier<CooStaffingModel> {
  CooStaffingNotifier() : super(const CooStaffingModel(isLoading: true));

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

final coo_staffingProvider = StateNotifierProvider<CooStaffingNotifier, CooStaffingModel>((ref) {
  return CooStaffingNotifier()..loadData();
});
