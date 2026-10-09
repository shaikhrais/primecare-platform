import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FamilyOverviewScreenState
    extends DashboardState<FamilyOverviewScreenState> {
  FamilyOverviewScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  FamilyOverviewScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      FamilyOverviewScreenState(isLoading: isLoading, error: error, data: data);
}

class FamilyOverviewScreenController
    extends BaseDashboardController<FamilyOverviewScreenState> {
  FamilyOverviewScreenController(Ref ref)
    : super(
        ref,
        initialState: FamilyOverviewScreenState(isLoading: true, data: {}),
        endpoint: '/common/family-overview',
      );
}

final family_overviewControllerProvider =
    StateNotifierProvider<
      FamilyOverviewScreenController,
      FamilyOverviewScreenState
    >((ref) {
      return FamilyOverviewScreenController(ref);
    });
