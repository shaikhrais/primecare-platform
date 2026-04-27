// Layer: 01_INFRASTRUCTURE
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/leave_request_form_view_model.dart';
import '../mappers/leave_request_form_mapper.dart';

class LeaveRequestFormAdapter extends Notifier<LeaveRequestFormViewModel> {
  @override
  LeaveRequestFormViewModel build() {
    return LeaveRequestFormViewModel();
  }

  void updateData(Map<String, dynamic> newData) {
    state = state.copyWith(data: {...state.data, ...newData});
  }

  Future<void> submit() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      // API call simulated
      await Future<void>.delayed(const Duration(seconds: 1));

      final dto = LeaveRequestFormMapper.toDto(state);
      // ignore: avoid_print
      print('Submitting leave request: ${dto.toJson()}');

      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      // ignore: avoid_print
      print('Error Submitting leave request: \$e');
    }
  }
}

final leaveRequestFormAdapterProvider =
    NotifierProvider<LeaveRequestFormAdapter, LeaveRequestFormViewModel>(() {
      return LeaveRequestFormAdapter();
    });
