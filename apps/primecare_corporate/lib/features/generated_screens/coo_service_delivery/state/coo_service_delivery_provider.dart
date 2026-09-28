import 'package:flutter_riverpod/legacy.dart';
import '../models/coo_service_delivery_model.dart';

class CooServiceDeliveryNotifier extends StateNotifier<CooServiceDeliveryModel> {
  CooServiceDeliveryNotifier() : super(const CooServiceDeliveryModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const <String, dynamic>{});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final coo_service_deliveryProvider = StateNotifierProvider<CooServiceDeliveryNotifier, CooServiceDeliveryModel>((ref) {
  return CooServiceDeliveryNotifier()..loadData();
});
