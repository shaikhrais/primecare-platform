import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/formulary_compliance_manager_model.dart';

class FormularyComplianceManagerNotifier extends StateNotifier<FormularyComplianceManagerModel> {
  FormularyComplianceManagerNotifier() : super(const FormularyComplianceManagerModel(isLoading: true));

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

final formulary_compliance_managerProvider = StateNotifierProvider<FormularyComplianceManagerNotifier, FormularyComplianceManagerModel>((ref) {
  return FormularyComplianceManagerNotifier()..loadData();
});
