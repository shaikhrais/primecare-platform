import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FamilyOverviewScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  FamilyOverviewScreenState({required this.isLoading, this.error, required this.data});

  FamilyOverviewScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return FamilyOverviewScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class FamilyOverviewScreenController extends StateNotifier<FamilyOverviewScreenState> {
  final Ref ref;
  FamilyOverviewScreenController(this.ref) : super(FamilyOverviewScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/common/family-overview');
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

final family_overviewControllerProvider = StateNotifierProvider<FamilyOverviewScreenController, FamilyOverviewScreenState>((ref) {
  return FamilyOverviewScreenController(ref);
});
