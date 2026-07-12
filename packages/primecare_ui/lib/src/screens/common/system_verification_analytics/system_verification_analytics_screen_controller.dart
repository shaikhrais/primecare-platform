import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SystemVerificationAnalyticsScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  SystemVerificationAnalyticsScreenState({required this.isLoading, this.error, required this.data});

  SystemVerificationAnalyticsScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return SystemVerificationAnalyticsScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class SystemVerificationAnalyticsScreenController extends StateNotifier<SystemVerificationAnalyticsScreenState> {
  final Ref ref;
  SystemVerificationAnalyticsScreenController(this.ref) : super(SystemVerificationAnalyticsScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/common/system-verification-analytics');
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

final system_verification_analyticsControllerProvider = StateNotifierProvider<SystemVerificationAnalyticsScreenController, SystemVerificationAnalyticsScreenState>((ref) {
  return SystemVerificationAnalyticsScreenController(ref);
});
