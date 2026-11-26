import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhysiotherapistBillingLinkScreenState
    extends DashboardState<PhysiotherapistBillingLinkScreenState> {
  PhysiotherapistBillingLinkScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PhysiotherapistBillingLinkScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PhysiotherapistBillingLinkScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class PhysiotherapistBillingLinkScreenController
    extends BaseDashboardController<PhysiotherapistBillingLinkScreenState> {
  PhysiotherapistBillingLinkScreenController(Ref ref)
    : super(
        ref,
        initialState: PhysiotherapistBillingLinkScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/clinical/roles/physiotherapist/billing-link',
      );
}

final physiotherapist_billing_linkControllerProvider =
    StateNotifierProvider<
      PhysiotherapistBillingLinkScreenController,
      PhysiotherapistBillingLinkScreenState
    >((ref) {
      return PhysiotherapistBillingLinkScreenController(ref);
    });
