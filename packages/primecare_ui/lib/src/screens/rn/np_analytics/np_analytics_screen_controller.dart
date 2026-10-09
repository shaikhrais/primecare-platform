import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NursePractitionerNpAnalyticsScreenState
    extends DashboardState<NursePractitionerNpAnalyticsScreenState> {
  NursePractitionerNpAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  NursePractitionerNpAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => NursePractitionerNpAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class NursePractitionerNpAnalyticsScreenController
    extends BaseDashboardController<NursePractitionerNpAnalyticsScreenState> {
  NursePractitionerNpAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: NursePractitionerNpAnalyticsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/rn/np-analytics',
      );
}

final np_analyticsControllerProvider =
    StateNotifierProvider<
      NursePractitionerNpAnalyticsScreenController,
      NursePractitionerNpAnalyticsScreenState
    >((ref) {
      return NursePractitionerNpAnalyticsScreenController(ref);
    });
