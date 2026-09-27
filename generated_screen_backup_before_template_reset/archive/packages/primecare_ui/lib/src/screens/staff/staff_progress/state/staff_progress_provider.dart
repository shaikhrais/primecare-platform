import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/staff_progress_model.dart';

class StaffProgressNotifier extends StateNotifier<StaffProgressModel> {
  StaffProgressNotifier() : super(const StaffProgressModel(isLoading: true));

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

final staff_progressProvider = StateNotifierProvider<StaffProgressNotifier, StaffProgressModel>((ref) {
  return StaffProgressNotifier()..loadData();
});
