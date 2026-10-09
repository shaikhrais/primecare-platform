import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FamilyMemberDashboardScreenState
    extends DashboardState<FamilyMemberDashboardScreenState> {
  FamilyMemberDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  FamilyMemberDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => FamilyMemberDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class FamilyMemberDashboardScreenController
    extends BaseDashboardController<FamilyMemberDashboardScreenState> {
  FamilyMemberDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: FamilyMemberDashboardScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/common/family-member-dashboard',
      );
}

final family_member_dashboardControllerProvider =
    StateNotifierProvider<
      FamilyMemberDashboardScreenController,
      FamilyMemberDashboardScreenState
    >((ref) {
      return FamilyMemberDashboardScreenController(ref);
    });
