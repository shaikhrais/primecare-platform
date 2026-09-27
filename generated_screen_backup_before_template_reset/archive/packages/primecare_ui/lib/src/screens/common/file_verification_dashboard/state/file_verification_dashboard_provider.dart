import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/file_verification_dashboard_model.dart';

class FileVerificationDashboardNotifier extends StateNotifier<FileVerificationDashboardModel> {
  FileVerificationDashboardNotifier() : super(const FileVerificationDashboardModel(isLoading: true));

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

final file_verification_dashboardProvider = StateNotifierProvider<FileVerificationDashboardNotifier, FileVerificationDashboardModel>((ref) {
  return FileVerificationDashboardNotifier()..loadData();
});
