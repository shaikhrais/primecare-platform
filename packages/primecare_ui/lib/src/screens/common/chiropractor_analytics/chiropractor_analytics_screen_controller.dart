import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChiropractorAnalyticsScreenState
    extends DashboardState<ChiropractorAnalyticsScreenState> {
  ChiropractorAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ChiropractorAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ChiropractorAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ChiropractorAnalyticsScreenController
    extends BaseDashboardController<ChiropractorAnalyticsScreenState> {
  ChiropractorAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: ChiropractorAnalyticsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/clinical/roles/chiropractor/analytics',
      );
}

final chiropractor_analyticsControllerProvider =
    StateNotifierProvider<
      ChiropractorAnalyticsScreenController,
      ChiropractorAnalyticsScreenState
    >((ref) {
      return ChiropractorAnalyticsScreenController(ref);
    });
