import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrDirectorCredentialExpiryScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  HrDirectorCredentialExpiryScreenState({required this.isLoading, this.error, required this.data});

  HrDirectorCredentialExpiryScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return HrDirectorCredentialExpiryScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class HrDirectorCredentialExpiryScreenController extends StateNotifier<HrDirectorCredentialExpiryScreenState> {
  final Ref ref;
  HrDirectorCredentialExpiryScreenController(this.ref) : super(HrDirectorCredentialExpiryScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/executive/hr-director-credential-expiry');
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

final hr_director_credential_expiryControllerProvider = StateNotifierProvider<HrDirectorCredentialExpiryScreenController, HrDirectorCredentialExpiryScreenState>((ref) {
  return HrDirectorCredentialExpiryScreenController(ref);
});
