import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClientProgressScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  ClientProgressScreenState({required this.isLoading, this.error, required this.data});

  ClientProgressScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return ClientProgressScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class ClientProgressScreenController extends StateNotifier<ClientProgressScreenState> {
  final Ref ref;
  ClientProgressScreenController(this.ref) : super(ClientProgressScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/clinical/roles/rmt/client-progress');
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

final client_progressControllerProvider = StateNotifierProvider<ClientProgressScreenController, ClientProgressScreenState>((ref) {
  return ClientProgressScreenController(ref);
});
