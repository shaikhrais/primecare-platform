import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BrandManagementScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  BrandManagementScreenState({required this.isLoading, this.error, required this.data});

  BrandManagementScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return BrandManagementScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class BrandManagementScreenController extends StateNotifier<BrandManagementScreenState> {
  final Ref ref;
  BrandManagementScreenController(this.ref) : super(BrandManagementScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/management/brand-management');
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

final brand_managementControllerProvider = StateNotifierProvider<BrandManagementScreenController, BrandManagementScreenState>((ref) {
  return BrandManagementScreenController(ref);
});
