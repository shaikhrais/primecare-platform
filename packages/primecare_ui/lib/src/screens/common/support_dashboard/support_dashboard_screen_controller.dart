import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SupportDashboardScreenState
    extends DashboardState<SupportDashboardScreenState> {
  SupportDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  SupportDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => SupportDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class SupportDashboardScreenController
    extends BaseDashboardController<SupportDashboardScreenState> {
  SupportDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: SupportDashboardScreenState(isLoading: true, data: {}),
        endpoint: '/common/support-dashboard',
      );
}

final support_dashboardControllerProvider =
    StateNotifierProvider<
      SupportDashboardScreenController,
      SupportDashboardScreenState
    >((ref) {
      return SupportDashboardScreenController(ref);
    });
