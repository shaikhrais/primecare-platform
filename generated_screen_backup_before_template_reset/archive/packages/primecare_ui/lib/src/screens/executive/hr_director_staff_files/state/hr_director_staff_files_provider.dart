import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/hr_director_staff_files_model.dart';

class HrDirectorStaffFilesNotifier extends StateNotifier<HrDirectorStaffFilesModel> {
  HrDirectorStaffFilesNotifier() : super(const HrDirectorStaffFilesModel(isLoading: true));

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

final hr_director_staff_filesProvider = StateNotifierProvider<HrDirectorStaffFilesNotifier, HrDirectorStaffFilesModel>((ref) {
  return HrDirectorStaffFilesNotifier()..loadData();
});
