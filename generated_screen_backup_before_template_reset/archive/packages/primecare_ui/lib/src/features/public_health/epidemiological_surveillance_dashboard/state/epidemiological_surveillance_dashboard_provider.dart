import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/epidemiological_surveillance_dashboard_model.dart';

class EpidemiologicalSurveillanceDashboardNotifier extends StateNotifier<EpidemiologicalSurveillanceDashboardModel> {
  EpidemiologicalSurveillanceDashboardNotifier() : super(const EpidemiologicalSurveillanceDashboardModel(isLoading: true));

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

final epidemiological_surveillance_dashboardProvider = StateNotifierProvider<EpidemiologicalSurveillanceDashboardNotifier, EpidemiologicalSurveillanceDashboardModel>((ref) {
  return EpidemiologicalSurveillanceDashboardNotifier()..loadData();
});
