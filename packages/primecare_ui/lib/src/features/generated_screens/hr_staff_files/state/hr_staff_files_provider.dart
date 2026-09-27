import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/hr_staff_files_model.dart';

class HrStaffFilesNotifier extends StateNotifier<HrStaffFilesModel> {
  HrStaffFilesNotifier() : super(const HrStaffFilesModel(isLoading: true));

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

final hr_staff_filesProvider = StateNotifierProvider<HrStaffFilesNotifier, HrStaffFilesModel>((ref) {
  return HrStaffFilesNotifier()..loadData();
});
