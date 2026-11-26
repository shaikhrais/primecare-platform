import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FamilyMemberWorkflowScreenState
    extends DashboardState<FamilyMemberWorkflowScreenState> {
  FamilyMemberWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  FamilyMemberWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => FamilyMemberWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class FamilyMemberWorkflowScreenController
    extends BaseDashboardController<FamilyMemberWorkflowScreenState> {
  FamilyMemberWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: FamilyMemberWorkflowScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/common/family-member-workflow',
      );
}

final family_member_workflowControllerProvider =
    StateNotifierProvider<
      FamilyMemberWorkflowScreenController,
      FamilyMemberWorkflowScreenState
    >((ref) {
      return FamilyMemberWorkflowScreenController(ref);
    });
