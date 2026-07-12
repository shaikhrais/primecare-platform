import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SsoRedirectScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  SsoRedirectScreenState({required this.isLoading, this.error, required this.data});

  SsoRedirectScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return SsoRedirectScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class SsoRedirectScreenController extends StateNotifier<SsoRedirectScreenState> {
  final Ref ref;
  SsoRedirectScreenController(this.ref) : super(SsoRedirectScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/generated/sso-redirect');
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

final sso_redirectControllerProvider = StateNotifierProvider<SsoRedirectScreenController, SsoRedirectScreenState>((ref) {
  return SsoRedirectScreenController(ref);
});
