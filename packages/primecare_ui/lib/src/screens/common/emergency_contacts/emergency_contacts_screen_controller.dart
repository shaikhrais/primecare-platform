import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmergencyContactsScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  EmergencyContactsScreenState({required this.isLoading, this.error, required this.data});

  EmergencyContactsScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return EmergencyContactsScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class EmergencyContactsScreenController extends StateNotifier<EmergencyContactsScreenState> {
  final Ref ref;
  EmergencyContactsScreenController(this.ref) : super(EmergencyContactsScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/common/emergency-contacts');
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

final emergency_contactsControllerProvider = StateNotifierProvider<EmergencyContactsScreenController, EmergencyContactsScreenState>((ref) {
  return EmergencyContactsScreenController(ref);
});
