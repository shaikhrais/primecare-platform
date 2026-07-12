import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhysiotherapistCommandCenterScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  PhysiotherapistCommandCenterScreenState({required this.isLoading, this.error, required this.data});

  PhysiotherapistCommandCenterScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return PhysiotherapistCommandCenterScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class PhysiotherapistCommandCenterScreenController extends StateNotifier<PhysiotherapistCommandCenterScreenState> {
  final Ref ref;
  PhysiotherapistCommandCenterScreenController(this.ref) : super(PhysiotherapistCommandCenterScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/clinical/roles/physiotherapist/command-center');
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

final physiotherapist_command_centerControllerProvider = StateNotifierProvider<PhysiotherapistCommandCenterScreenController, PhysiotherapistCommandCenterScreenState>((ref) {
  return PhysiotherapistCommandCenterScreenController(ref);
});
