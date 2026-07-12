import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuditReviewScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  AuditReviewScreenState({required this.isLoading, this.error, required this.data});

  AuditReviewScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return AuditReviewScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class AuditReviewScreenController extends StateNotifier<AuditReviewScreenState> {
  final Ref ref;
  AuditReviewScreenController(this.ref) : super(AuditReviewScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/management/audit-review');
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

final audit_reviewControllerProvider = StateNotifierProvider<AuditReviewScreenController, AuditReviewScreenState>((ref) {
  return AuditReviewScreenController(ref);
});
