import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/quality_assurance_corrective_actions_model.dart';

class QualityAssuranceCorrectiveActionsNotifier extends StateNotifier<QualityAssuranceCorrectiveActionsModel> {
  QualityAssuranceCorrectiveActionsNotifier() : super(const QualityAssuranceCorrectiveActionsModel(isLoading: true));

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

final quality_assurance_corrective_actionsProvider = StateNotifierProvider<QualityAssuranceCorrectiveActionsNotifier, QualityAssuranceCorrectiveActionsModel>((ref) {
  return QualityAssuranceCorrectiveActionsNotifier()..loadData();
});
