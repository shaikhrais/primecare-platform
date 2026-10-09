import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CisoDashboardScreenState
    extends DashboardState<CisoDashboardScreenState> {
  CisoDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CisoDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      CisoDashboardScreenState(isLoading: isLoading, error: error, data: data);
}

class CisoDashboardScreenController
    extends BaseDashboardController<CisoDashboardScreenState> {
  CisoDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: CisoDashboardScreenState(isLoading: true, data: {}),
        endpoint: '/offices/corporate/roles/ciso/dashboard',
      );
}

final ciso_dashboardControllerProvider =
    StateNotifierProvider<
      CisoDashboardScreenController,
      CisoDashboardScreenState
    >((ref) {
      return CisoDashboardScreenController(ref);
    });
