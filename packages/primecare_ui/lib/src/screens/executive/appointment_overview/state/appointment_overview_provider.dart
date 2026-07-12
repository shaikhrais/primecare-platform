import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/appointment_overview_model.dart';

class AppointmentOverviewNotifier extends StateNotifier<AppointmentOverviewModel> {
  AppointmentOverviewNotifier() : super(const AppointmentOverviewModel(isLoading: true));

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

final appointment_overviewProvider = StateNotifierProvider<AppointmentOverviewNotifier, AppointmentOverviewModel>((ref) {
  return AppointmentOverviewNotifier()..loadData();
});
