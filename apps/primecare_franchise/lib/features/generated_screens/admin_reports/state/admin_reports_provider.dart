import 'package:flutter_riverpod/legacy.dart';
import '../models/admin_reports_model.dart';

class AdminReportsNotifier extends StateNotifier<AdminReportsModel> {
  AdminReportsNotifier() : super(const AdminReportsModel(isLoading: true));

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

final admin_reportsProvider = StateNotifierProvider<AdminReportsNotifier, AdminReportsModel>((ref) {
  return AdminReportsNotifier()..loadData();
});
