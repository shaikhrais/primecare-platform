import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LegalDashboardScreenState
    extends DashboardState<LegalDashboardScreenState> {
  LegalDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  LegalDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      LegalDashboardScreenState(isLoading: isLoading, error: error, data: data);
}

class LegalDashboardScreenController
    extends BaseDashboardController<LegalDashboardScreenState> {
  LegalDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: LegalDashboardScreenState(isLoading: true, data: {}),
        endpoint: '/offices/corporate/roles/legal/dashboard',
      );
}

final legal_dashboardControllerProvider =
    StateNotifierProvider<
      LegalDashboardScreenController,
      LegalDashboardScreenState
    >((ref) {
      return LegalDashboardScreenController(ref);
    });
