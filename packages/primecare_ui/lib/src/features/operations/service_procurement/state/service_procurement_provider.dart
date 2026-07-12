import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/service_procurement_model.dart';

class ServiceProcurementNotifier extends StateNotifier<ServiceProcurementModel> {
  ServiceProcurementNotifier() : super(const ServiceProcurementModel(isLoading: true));

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

final service_procurementProvider = StateNotifierProvider<ServiceProcurementNotifier, ServiceProcurementModel>((ref) {
  return ServiceProcurementNotifier()..loadData();
});
