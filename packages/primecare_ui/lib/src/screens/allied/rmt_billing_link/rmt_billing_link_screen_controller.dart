import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RmtBillingLinkScreenState
    extends DashboardState<RmtBillingLinkScreenState> {
  RmtBillingLinkScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RmtBillingLinkScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      RmtBillingLinkScreenState(isLoading: isLoading, error: error, data: data);
}

class RmtBillingLinkScreenController
    extends BaseDashboardController<RmtBillingLinkScreenState> {
  RmtBillingLinkScreenController(Ref ref)
    : super(
        ref,
        initialState: RmtBillingLinkScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/rmt/billing-link',
      );
}

final rmt_billing_linkControllerProvider =
    StateNotifierProvider<
      RmtBillingLinkScreenController,
      RmtBillingLinkScreenState
    >((ref) {
      return RmtBillingLinkScreenController(ref);
    });
