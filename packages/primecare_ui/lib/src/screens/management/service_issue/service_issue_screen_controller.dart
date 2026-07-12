import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ServiceIssueScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  ServiceIssueScreenState({required this.isLoading, this.error, required this.data});

  ServiceIssueScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return ServiceIssueScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class ServiceIssueScreenController extends StateNotifier<ServiceIssueScreenState> {
  final Ref ref;
  ServiceIssueScreenController(this.ref) : super(ServiceIssueScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/management/service-issue');
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

final service_issueControllerProvider = StateNotifierProvider<ServiceIssueScreenController, ServiceIssueScreenState>((ref) {
  return ServiceIssueScreenController(ref);
});
