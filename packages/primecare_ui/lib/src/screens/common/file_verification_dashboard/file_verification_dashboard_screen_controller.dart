import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FileVerificationDashboardScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  FileVerificationDashboardScreenState({required this.isLoading, this.error, required this.data});

  FileVerificationDashboardScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return FileVerificationDashboardScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class FileVerificationDashboardScreenController extends StateNotifier<FileVerificationDashboardScreenState> {
  final Ref ref;
  FileVerificationDashboardScreenController(this.ref) : super(FileVerificationDashboardScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/common/file-verification-dashboard');
      if (response.isSuccess) {
        state = state.copyWith(
          isLoading: false,
          data: response.data is Map ? Map<String, dynamic>.from(response.data) : {},
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: response.error ?? 'Failed to load live data',
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> syncData() async {
    await loadDashboardData();
  }
}

final file_verification_dashboardControllerProvider = StateNotifierProvider<FileVerificationDashboardScreenController, FileVerificationDashboardScreenState>((ref) {
  return FileVerificationDashboardScreenController(ref);
});
