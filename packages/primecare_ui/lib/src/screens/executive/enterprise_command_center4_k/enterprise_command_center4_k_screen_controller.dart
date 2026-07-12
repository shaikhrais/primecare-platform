import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EnterpriseCommandCenter4KScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  EnterpriseCommandCenter4KScreenState({required this.isLoading, this.error, required this.data});

  EnterpriseCommandCenter4KScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return EnterpriseCommandCenter4KScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class EnterpriseCommandCenter4KScreenController extends StateNotifier<EnterpriseCommandCenter4KScreenState> {
  final Ref ref;
  EnterpriseCommandCenter4KScreenController(this.ref) : super(EnterpriseCommandCenter4KScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/executive/enterprise-command-center4-k');
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

final enterprise_command_center4_kControllerProvider = StateNotifierProvider<EnterpriseCommandCenter4KScreenController, EnterpriseCommandCenter4KScreenState>((ref) {
  return EnterpriseCommandCenter4KScreenController(ref);
});
