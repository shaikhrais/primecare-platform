import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/head_of_bus_dev_compliance_model.dart';

class HeadOfBusDevComplianceNotifier extends StateNotifier<HeadOfBusDevComplianceModel> {
  HeadOfBusDevComplianceNotifier() : super(const HeadOfBusDevComplianceModel(isLoading: true));

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

final head_of_bus_dev_complianceProvider = StateNotifierProvider<HeadOfBusDevComplianceNotifier, HeadOfBusDevComplianceModel>((ref) {
  return HeadOfBusDevComplianceNotifier()..loadData();
});
