import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LicensedPracticalNurseLpnAnalyticsScreenState
    extends DashboardState<LicensedPracticalNurseLpnAnalyticsScreenState> {
  LicensedPracticalNurseLpnAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  LicensedPracticalNurseLpnAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => LicensedPracticalNurseLpnAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class LicensedPracticalNurseLpnAnalyticsScreenController
    extends
        BaseDashboardController<LicensedPracticalNurseLpnAnalyticsScreenState> {
  LicensedPracticalNurseLpnAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: LicensedPracticalNurseLpnAnalyticsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/rpn/lpn-analytics',
      );
}

final lpn_analyticsControllerProvider =
    StateNotifierProvider<
      LicensedPracticalNurseLpnAnalyticsScreenController,
      LicensedPracticalNurseLpnAnalyticsScreenState
    >((ref) {
      return LicensedPracticalNurseLpnAnalyticsScreenController(ref);
    });
