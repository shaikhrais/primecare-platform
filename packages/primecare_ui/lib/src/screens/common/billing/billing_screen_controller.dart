import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BillingScreenState extends DashboardState<BillingScreenState> {
  BillingScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  BillingScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => BillingScreenState(isLoading: isLoading, error: error, data: data);
}

class BillingScreenController
    extends BaseDashboardController<BillingScreenState> {
  BillingScreenController(Ref ref)
    : super(
        ref,
        initialState: BillingScreenState(isLoading: true, data: {}),
        endpoint: '/common/billing',
      );
}

final billingControllerProvider =
    StateNotifierProvider<BillingScreenController, BillingScreenState>((ref) {
      return BillingScreenController(ref);
    });
