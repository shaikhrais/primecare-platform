import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/service_quality_model.dart';

class ServiceQualityNotifier extends StateNotifier<ServiceQualityModel> {
  ServiceQualityNotifier() : super(const ServiceQualityModel(isLoading: true));

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

final service_qualityProvider = StateNotifierProvider<ServiceQualityNotifier, ServiceQualityModel>((ref) {
  return ServiceQualityNotifier()..loadData();
});
