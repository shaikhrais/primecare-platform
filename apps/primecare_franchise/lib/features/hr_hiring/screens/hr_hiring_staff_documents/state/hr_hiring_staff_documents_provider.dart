import 'package:flutter_riverpod/legacy.dart';
import '../models/hr_hiring_staff_documents_model.dart';

class HrHiringStaffDocumentsNotifier extends StateNotifier<HrHiringStaffDocumentsModel> {
  HrHiringStaffDocumentsNotifier() : super(const HrHiringStaffDocumentsModel(isLoading: true));

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

final hr_hiring_staff_documentsProvider = StateNotifierProvider<HrHiringStaffDocumentsNotifier, HrHiringStaffDocumentsModel>((ref) {
  return HrHiringStaffDocumentsNotifier()..loadData();
});
