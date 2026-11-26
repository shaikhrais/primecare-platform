import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChiropractorBillingLinkScreenState
    extends DashboardState<ChiropractorBillingLinkScreenState> {
  ChiropractorBillingLinkScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ChiropractorBillingLinkScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ChiropractorBillingLinkScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ChiropractorBillingLinkScreenController
    extends BaseDashboardController<ChiropractorBillingLinkScreenState> {
  ChiropractorBillingLinkScreenController(Ref ref)
    : super(
        ref,
        initialState: ChiropractorBillingLinkScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/clinical/roles/chiropractor/billing-link',
      );
}

final chiropractor_billing_linkControllerProvider =
    StateNotifierProvider<
      ChiropractorBillingLinkScreenController,
      ChiropractorBillingLinkScreenState
    >((ref) {
      return ChiropractorBillingLinkScreenController(ref);
    });
