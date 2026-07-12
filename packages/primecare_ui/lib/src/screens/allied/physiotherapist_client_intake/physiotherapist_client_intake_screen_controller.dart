import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhysiotherapistClientIntakeScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  PhysiotherapistClientIntakeScreenState({required this.isLoading, this.error, required this.data});

  PhysiotherapistClientIntakeScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return PhysiotherapistClientIntakeScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class PhysiotherapistClientIntakeScreenController extends StateNotifier<PhysiotherapistClientIntakeScreenState> {
  final Ref ref;
  PhysiotherapistClientIntakeScreenController(this.ref) : super(PhysiotherapistClientIntakeScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/clinical/roles/physiotherapist/client-intake');
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

final physiotherapist_client_intakeControllerProvider = StateNotifierProvider<PhysiotherapistClientIntakeScreenController, PhysiotherapistClientIntakeScreenState>((ref) {
  return PhysiotherapistClientIntakeScreenController(ref);
});
