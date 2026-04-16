import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/schedule_interview_form_view_model.dart';
import '../mappers/schedule_interview_form_mapper.dart';

class ScheduleInterviewFormAdapter
    extends Notifier<ScheduleInterviewFormViewModel> {
  @override
  ScheduleInterviewFormViewModel build() {
    return ScheduleInterviewFormViewModel();
  }

  void updateData(Map<String, dynamic> newData) {
    state = state.copyWith(data: {...state.data, ...newData});
  }

  Future<void> submit() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      // API call simulated
      await Future.delayed(const Duration(seconds: 1));

      final dto = ScheduleInterviewFormMapper.toDto(state);
      // ignore: avoid_print
      print('Scheduling interview: ${dto.toJson()}');

      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      // ignore: avoid_print
      print('Error scheduling interview: \$e');
    }
  }
}

final scheduleInterviewFormAdapterProvider =
    NotifierProvider<
      ScheduleInterviewFormAdapter,
      ScheduleInterviewFormViewModel
    >(() {
      return ScheduleInterviewFormAdapter();
    });
