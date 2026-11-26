import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FamilyMemberAnalyticsScreenState
    extends DashboardState<FamilyMemberAnalyticsScreenState> {
  FamilyMemberAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  FamilyMemberAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => FamilyMemberAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class FamilyMemberAnalyticsScreenController
    extends BaseDashboardController<FamilyMemberAnalyticsScreenState> {
  FamilyMemberAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: FamilyMemberAnalyticsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/common/family-member-analytics',
      );
}

final family_member_analyticsControllerProvider =
    StateNotifierProvider<
      FamilyMemberAnalyticsScreenController,
      FamilyMemberAnalyticsScreenState
    >((ref) {
      return FamilyMemberAnalyticsScreenController(ref);
    });
