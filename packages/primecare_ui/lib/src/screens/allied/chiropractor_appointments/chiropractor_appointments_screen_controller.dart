import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChiropractorAppointmentsScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  ChiropractorAppointmentsScreenState({required this.isLoading, this.error, required this.data});

  ChiropractorAppointmentsScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return ChiropractorAppointmentsScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class ChiropractorAppointmentsScreenController extends StateNotifier<ChiropractorAppointmentsScreenState> {
  final Ref ref;
  ChiropractorAppointmentsScreenController(this.ref) : super(ChiropractorAppointmentsScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/clinical/roles/chiropractor/appointments');
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

final chiropractor_appointmentsControllerProvider = StateNotifierProvider<ChiropractorAppointmentsScreenController, ChiropractorAppointmentsScreenState>((ref) {
  return ChiropractorAppointmentsScreenController(ref);
});
