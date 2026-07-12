import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PortalComplianceScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  PortalComplianceScreenState({required this.isLoading, this.error, required this.data});

  PortalComplianceScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return PortalComplianceScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class PortalComplianceScreenController extends StateNotifier<PortalComplianceScreenState> {
  final Ref ref;
  PortalComplianceScreenController(this.ref) : super(PortalComplianceScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/common/portal-compliance');
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

final portal_complianceControllerProvider = StateNotifierProvider<PortalComplianceScreenController, PortalComplianceScreenState>((ref) {
  return PortalComplianceScreenController(ref);
});
