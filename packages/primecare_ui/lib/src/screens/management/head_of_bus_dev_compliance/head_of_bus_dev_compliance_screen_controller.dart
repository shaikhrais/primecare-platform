import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HeadOfBusDevComplianceScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  HeadOfBusDevComplianceScreenState({required this.isLoading, this.error, required this.data});

  HeadOfBusDevComplianceScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return HeadOfBusDevComplianceScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class HeadOfBusDevComplianceScreenController extends StateNotifier<HeadOfBusDevComplianceScreenState> {
  final Ref ref;
  HeadOfBusDevComplianceScreenController(this.ref) : super(HeadOfBusDevComplianceScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/management/head-of-bus-dev-compliance');
      if (response.isSuccess) {
        final responseData = response.data;
        state = state.copyWith(
          isLoading: false,
          data: responseData is Map ? Map<String, dynamic>.from(responseData) : {},
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

final head_of_bus_dev_complianceControllerProvider = StateNotifierProvider<HeadOfBusDevComplianceScreenController, HeadOfBusDevComplianceScreenState>((ref) {
  return HeadOfBusDevComplianceScreenController(ref);
});
