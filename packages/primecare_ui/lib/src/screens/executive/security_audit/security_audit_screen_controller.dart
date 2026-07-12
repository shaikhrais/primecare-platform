import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SecurityAuditScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  SecurityAuditScreenState({required this.isLoading, this.error, required this.data});

  SecurityAuditScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return SecurityAuditScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class SecurityAuditScreenController extends StateNotifier<SecurityAuditScreenState> {
  final Ref ref;
  SecurityAuditScreenController(this.ref) : super(SecurityAuditScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/executive/security-audit');
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

final security_auditControllerProvider = StateNotifierProvider<SecurityAuditScreenController, SecurityAuditScreenState>((ref) {
  return SecurityAuditScreenController(ref);
});
