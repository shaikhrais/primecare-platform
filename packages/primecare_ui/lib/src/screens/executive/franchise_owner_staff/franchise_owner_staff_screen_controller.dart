import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FranchiseOwnerStaffScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  FranchiseOwnerStaffScreenState({required this.isLoading, this.error, required this.data});

  FranchiseOwnerStaffScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return FranchiseOwnerStaffScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class FranchiseOwnerStaffScreenController extends StateNotifier<FranchiseOwnerStaffScreenState> {
  final Ref ref;
  FranchiseOwnerStaffScreenController(this.ref) : super(FranchiseOwnerStaffScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/franchise/roles/franchise_owner/staff');
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

final franchise_owner_staffControllerProvider = StateNotifierProvider<FranchiseOwnerStaffScreenController, FranchiseOwnerStaffScreenState>((ref) {
  return FranchiseOwnerStaffScreenController(ref);
});
