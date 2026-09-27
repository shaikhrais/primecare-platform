import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/payment_tracking_model.dart';

class PaymentTrackingNotifier extends StateNotifier<PaymentTrackingModel> {
  PaymentTrackingNotifier() : super(const PaymentTrackingModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const {});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final payment_trackingProvider = StateNotifierProvider<PaymentTrackingNotifier, PaymentTrackingModel>((ref) {
  return PaymentTrackingNotifier()..loadData();
});
