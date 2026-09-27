import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LegalComplianceScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  LegalComplianceScreenState({required this.isLoading, this.error, required this.data});

  LegalComplianceScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return LegalComplianceScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class LegalComplianceScreenController extends StateNotifier<LegalComplianceScreenState> {
  final Ref ref;
  LegalComplianceScreenController(this.ref) : super(LegalComplianceScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/executive/legal-compliance');
      if (response.isSuccess) {
        final responseData = response.data;
        state = state.copyWith(
          isLoading: false,
          data: responseData is Map ? Map<String, dynamic>.from(responseData) : {},
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

final legal_complianceControllerProvider = StateNotifierProvider<LegalComplianceScreenController, LegalComplianceScreenState>((ref) {
  return LegalComplianceScreenController(ref);
});
