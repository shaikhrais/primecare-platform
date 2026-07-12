import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchedulerProviderAvailabilityScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  SchedulerProviderAvailabilityScreenState({required this.isLoading, this.error, required this.data});

  SchedulerProviderAvailabilityScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return SchedulerProviderAvailabilityScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class SchedulerProviderAvailabilityScreenController extends StateNotifier<SchedulerProviderAvailabilityScreenState> {
  final Ref ref;
  SchedulerProviderAvailabilityScreenController(this.ref) : super(SchedulerProviderAvailabilityScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/staff/scheduler-provider-availability');
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

final scheduler_provider_availabilityControllerProvider = StateNotifierProvider<SchedulerProviderAvailabilityScreenController, SchedulerProviderAvailabilityScreenState>((ref) {
  return SchedulerProviderAvailabilityScreenController(ref);
});
