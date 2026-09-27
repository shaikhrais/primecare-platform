import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VitalsEntryScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  VitalsEntryScreenState({required this.isLoading, this.error, required this.data});

  VitalsEntryScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return VitalsEntryScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class VitalsEntryScreenController extends StateNotifier<VitalsEntryScreenState> {
  final Ref ref;
  VitalsEntryScreenController(this.ref) : super(VitalsEntryScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/clinical/roles/psw/observation-vitals-log');
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

final psw_vitals_logControllerProvider = StateNotifierProvider<VitalsEntryScreenController, VitalsEntryScreenState>((ref) {
  return VitalsEntryScreenController(ref);
});
