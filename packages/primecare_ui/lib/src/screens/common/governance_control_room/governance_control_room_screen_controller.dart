import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GovernanceControlRoomScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  GovernanceControlRoomScreenState({required this.isLoading, this.error, required this.data});

  GovernanceControlRoomScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return GovernanceControlRoomScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class GovernanceControlRoomScreenController extends StateNotifier<GovernanceControlRoomScreenState> {
  final Ref ref;
  GovernanceControlRoomScreenController(this.ref) : super(GovernanceControlRoomScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/common/governance-control-room');
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

final governance_control_roomControllerProvider = StateNotifierProvider<GovernanceControlRoomScreenController, GovernanceControlRoomScreenState>((ref) {
  return GovernanceControlRoomScreenController(ref);
});
