import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PswAnalyticsScreenState extends DashboardState<PswAnalyticsScreenState> {
  PswAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PswAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PswAnalyticsScreenState(isLoading: isLoading, error: error, data: data);
}

class PswAnalyticsScreenController
    extends BaseDashboardController<PswAnalyticsScreenState> {
  PswAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: PswAnalyticsScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/psw/reports',
      );
}

final psw_analyticsControllerProvider =
    StateNotifierProvider<
      PswAnalyticsScreenController,
      PswAnalyticsScreenState
    >((ref) {
      return PswAnalyticsScreenController(ref);
    });
