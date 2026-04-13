import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/schedule_open_house_form_view_model.dart';
import '../mappers/schedule_open_house_form_mapper.dart';

class ScheduleOpenHouseFormAdapter extends Notifier<ScheduleOpenHouseFormViewModel> {
  @override
  ScheduleOpenHouseFormViewModel build() {
    return ScheduleOpenHouseFormViewModel();
  }

  void updateData(Map<String, dynamic> newData) {
    state = state.copyWith(data: {...state.data, ...newData});
  }

  Future<void> submit() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      // API call simulated
      await Future.delayed(const Duration(seconds: 1));
      
      final dto = ScheduleOpenHouseFormMapper.toDto(state);
      // ignore: avoid_print
      print('Submitting Schedule Open House: ${dto.toJson()}');
      
      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      // ignore: avoid_print
      print('Error Submitting Schedule Open House: \$e');
    }
  }
}

final scheduleOpenHouseFormAdapterProvider =
    NotifierProvider<ScheduleOpenHouseFormAdapter, ScheduleOpenHouseFormViewModel>(() {
  return ScheduleOpenHouseFormAdapter();
});
