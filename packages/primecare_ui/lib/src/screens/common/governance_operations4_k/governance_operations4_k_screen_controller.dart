import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GovernanceOperations4KScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  GovernanceOperations4KScreenState({required this.isLoading, this.error, required this.data});

  GovernanceOperations4KScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return GovernanceOperations4KScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class GovernanceOperations4KScreenController extends StateNotifier<GovernanceOperations4KScreenState> {
  final Ref ref;
  GovernanceOperations4KScreenController(this.ref) : super(GovernanceOperations4KScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/common/governance-operations4-k');
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

final governance_operations4_kControllerProvider = StateNotifierProvider<GovernanceOperations4KScreenController, GovernanceOperations4KScreenState>((ref) {
  return GovernanceOperations4KScreenController(ref);
});
