import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaymentTrackingScreenState
    extends DashboardState<PaymentTrackingScreenState> {
  PaymentTrackingScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PaymentTrackingScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PaymentTrackingScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class PaymentTrackingScreenController
    extends BaseDashboardController<PaymentTrackingScreenState> {
  PaymentTrackingScreenController(Ref ref)
    : super(
        ref,
        initialState: PaymentTrackingScreenState(isLoading: true, data: {}),
        endpoint: '/staff/payment-tracking',
      );
}

final payment_trackingControllerProvider =
    StateNotifierProvider<
      PaymentTrackingScreenController,
      PaymentTrackingScreenState
    >((ref) {
      return PaymentTrackingScreenController(ref);
    });
