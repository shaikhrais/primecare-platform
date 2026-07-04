import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/operations_manager_service_quality_model.dart';

class OperationsManagerServiceQualityNotifier extends StateNotifier<OperationsManagerServiceQualityModel> {
  OperationsManagerServiceQualityNotifier() : super(const OperationsManagerServiceQualityModel(isLoading: true));

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

final operations_manager_service_qualityProvider = StateNotifierProvider<OperationsManagerServiceQualityNotifier, OperationsManagerServiceQualityModel>((ref) {
  return OperationsManagerServiceQualityNotifier()..loadData();
});
