import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/qa_dashboard_model.dart';

class QaDashboardNotifier extends StateNotifier<QaDashboardModel> {
  QaDashboardNotifier() : super(const QaDashboardModel(isLoading: true));

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

final qa_dashboardProvider = StateNotifierProvider<QaDashboardNotifier, QaDashboardModel>((ref) {
  return QaDashboardNotifier()..loadData();
});
