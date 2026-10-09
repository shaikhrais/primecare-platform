import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShareholderAnalyticsScreenState
    extends DashboardState<ShareholderAnalyticsScreenState> {
  ShareholderAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ShareholderAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ShareholderAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ShareholderAnalyticsScreenController
    extends BaseDashboardController<ShareholderAnalyticsScreenState> {
  ShareholderAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: ShareholderAnalyticsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/executive/shareholder-analytics',
      );
}

final shareholder_analyticsControllerProvider =
    StateNotifierProvider<
      ShareholderAnalyticsScreenController,
      ShareholderAnalyticsScreenState
    >((ref) {
      return ShareholderAnalyticsScreenController(ref);
    });
