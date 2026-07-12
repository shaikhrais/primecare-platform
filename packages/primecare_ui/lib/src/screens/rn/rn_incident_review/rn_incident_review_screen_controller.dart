import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RnIncidentReviewScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  RnIncidentReviewScreenState({required this.isLoading, this.error, required this.data});

  RnIncidentReviewScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return RnIncidentReviewScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class RnIncidentReviewScreenController extends StateNotifier<RnIncidentReviewScreenState> {
  final Ref ref;
  RnIncidentReviewScreenController(this.ref) : super(RnIncidentReviewScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/clinical/roles/rn/rn-incident-review');
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

final rn_incident_reviewControllerProvider = StateNotifierProvider<RnIncidentReviewScreenController, RnIncidentReviewScreenState>((ref) {
  return RnIncidentReviewScreenController(ref);
});
