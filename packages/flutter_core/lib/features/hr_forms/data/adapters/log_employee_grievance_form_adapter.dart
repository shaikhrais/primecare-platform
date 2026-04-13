import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/log_employee_grievance_form_view_model.dart';
import '../mappers/log_employee_grievance_form_mapper.dart';

class LogEmployeeGrievanceFormAdapter extends Notifier<LogEmployeeGrievanceFormViewModel> {
  @override
  LogEmployeeGrievanceFormViewModel build() {
    return LogEmployeeGrievanceFormViewModel();
  }

  void updateData(Map<String, dynamic> newData) {
    state = state.copyWith(data: {...state.data, ...newData});
  }

  Future<void> submit() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      // API call simulated
      await Future.delayed(const Duration(seconds: 1));
      
      final dto = LogEmployeeGrievanceFormMapper.toDto(state);
      // ignore: avoid_print
      print('Logging employee grievance: ${dto.toJson()}');
      
      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      // ignore: avoid_print
      print('Error logging employee grievance: \$e');
    }
  }
}

final logEmployeeGrievanceFormAdapterProvider =
    NotifierProvider<LogEmployeeGrievanceFormAdapter, LogEmployeeGrievanceFormViewModel>(() {
  return LogEmployeeGrievanceFormAdapter();
});
