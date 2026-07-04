import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/school_health_program_dashboard_model.dart';

class SchoolHealthProgramDashboardNotifier extends StateNotifier<SchoolHealthProgramDashboardModel> {
  SchoolHealthProgramDashboardNotifier() : super(const SchoolHealthProgramDashboardModel(isLoading: true));

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

final school_health_program_dashboardProvider = StateNotifierProvider<SchoolHealthProgramDashboardNotifier, SchoolHealthProgramDashboardModel>((ref) {
  return SchoolHealthProgramDashboardNotifier()..loadData();
});
