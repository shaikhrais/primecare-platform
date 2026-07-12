import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApplicantTrackingScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  ApplicantTrackingScreenState({required this.isLoading, this.error, required this.data});

  ApplicantTrackingScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return ApplicantTrackingScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class ApplicantTrackingScreenController extends StateNotifier<ApplicantTrackingScreenState> {
  final Ref ref;
  ApplicantTrackingScreenController(this.ref) : super(ApplicantTrackingScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/staff/applicant-tracking');
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

final applicant_trackingControllerProvider = StateNotifierProvider<ApplicantTrackingScreenController, ApplicantTrackingScreenState>((ref) {
  return ApplicantTrackingScreenController(ref);
});
