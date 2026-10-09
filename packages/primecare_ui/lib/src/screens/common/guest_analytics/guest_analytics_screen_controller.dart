import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GuestAnalyticsScreenState
    extends DashboardState<GuestAnalyticsScreenState> {
  GuestAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  GuestAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      GuestAnalyticsScreenState(isLoading: isLoading, error: error, data: data);
}

class GuestAnalyticsScreenController
    extends BaseDashboardController<GuestAnalyticsScreenState> {
  GuestAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: GuestAnalyticsScreenState(isLoading: true, data: {}),
        endpoint: '/common/guest-analytics',
      );
}

final guest_analyticsControllerProvider =
    StateNotifierProvider<
      GuestAnalyticsScreenController,
      GuestAnalyticsScreenState
    >((ref) {
      return GuestAnalyticsScreenController(ref);
    });
