import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OfficeDashboardScreenState
    extends DashboardState<OfficeDashboardScreenState> {
  OfficeDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  OfficeDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => OfficeDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class OfficeDashboardScreenController
    extends BaseDashboardController<OfficeDashboardScreenState> {
  OfficeDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: OfficeDashboardScreenState(isLoading: true, data: {}),
        endpoint: '/common/office-dashboard',
      );
}

final office_dashboardControllerProvider =
    StateNotifierProvider<
      OfficeDashboardScreenController,
      OfficeDashboardScreenState
    >((ref) {
      return OfficeDashboardScreenController(ref);
    });
