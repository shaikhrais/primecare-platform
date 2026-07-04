import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/employee_records_model.dart';

class EmployeeRecordsNotifier extends StateNotifier<EmployeeRecordsModel> {
  EmployeeRecordsNotifier() : super(const EmployeeRecordsModel(isLoading: true));

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

final employee_recordsProvider = StateNotifierProvider<EmployeeRecordsNotifier, EmployeeRecordsModel>((ref) {
  return EmployeeRecordsNotifier()..loadData();
});
