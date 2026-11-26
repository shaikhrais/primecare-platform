import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FamilyMemberComplianceScreenState
    extends DashboardState<FamilyMemberComplianceScreenState> {
  FamilyMemberComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  FamilyMemberComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => FamilyMemberComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class FamilyMemberComplianceScreenController
    extends BaseDashboardController<FamilyMemberComplianceScreenState> {
  FamilyMemberComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: FamilyMemberComplianceScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/common/family-member-compliance',
      );
}

final family_member_complianceControllerProvider =
    StateNotifierProvider<
      FamilyMemberComplianceScreenController,
      FamilyMemberComplianceScreenState
    >((ref) {
      return FamilyMemberComplianceScreenController(ref);
    });
