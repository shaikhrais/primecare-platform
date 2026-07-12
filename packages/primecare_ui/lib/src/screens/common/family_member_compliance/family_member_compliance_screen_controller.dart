import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FamilyMemberComplianceScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  FamilyMemberComplianceScreenState({required this.isLoading, this.error, required this.data});

  FamilyMemberComplianceScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return FamilyMemberComplianceScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class FamilyMemberComplianceScreenController extends StateNotifier<FamilyMemberComplianceScreenState> {
  final Ref ref;
  FamilyMemberComplianceScreenController(this.ref) : super(FamilyMemberComplianceScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/common/family-member-compliance');
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

final family_member_complianceControllerProvider = StateNotifierProvider<FamilyMemberComplianceScreenController, FamilyMemberComplianceScreenState>((ref) {
  return FamilyMemberComplianceScreenController(ref);
});
