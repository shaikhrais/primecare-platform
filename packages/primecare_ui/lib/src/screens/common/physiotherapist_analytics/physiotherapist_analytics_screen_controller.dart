import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhysiotherapistAnalyticsScreenState
    extends DashboardState<PhysiotherapistAnalyticsScreenState> {
  PhysiotherapistAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PhysiotherapistAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PhysiotherapistAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class PhysiotherapistAnalyticsScreenController
    extends BaseDashboardController<PhysiotherapistAnalyticsScreenState> {
  PhysiotherapistAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: PhysiotherapistAnalyticsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/clinical/roles/physiotherapist/analytics',
      );
}

final physiotherapist_analyticsControllerProvider =
    StateNotifierProvider<
      PhysiotherapistAnalyticsScreenController,
      PhysiotherapistAnalyticsScreenState
    >((ref) {
      return PhysiotherapistAnalyticsScreenController(ref);
    });
