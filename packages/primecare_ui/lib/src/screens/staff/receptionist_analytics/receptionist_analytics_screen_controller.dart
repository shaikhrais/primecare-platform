import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReceptionistAnalyticsScreenState
    extends DashboardState<ReceptionistAnalyticsScreenState> {
  ReceptionistAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ReceptionistAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ReceptionistAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ReceptionistAnalyticsScreenController
    extends BaseDashboardController<ReceptionistAnalyticsScreenState> {
  ReceptionistAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: ReceptionistAnalyticsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/staff/receptionist-analytics',
      );
}

final receptionist_analyticsControllerProvider =
    StateNotifierProvider<
      ReceptionistAnalyticsScreenController,
      ReceptionistAnalyticsScreenState
    >((ref) {
      return ReceptionistAnalyticsScreenController(ref);
    });
