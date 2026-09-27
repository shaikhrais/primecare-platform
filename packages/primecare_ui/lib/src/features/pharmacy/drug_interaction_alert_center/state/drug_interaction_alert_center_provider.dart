import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/drug_interaction_alert_center_model.dart';

class DrugInteractionAlertCenterNotifier extends StateNotifier<DrugInteractionAlertCenterModel> {
  DrugInteractionAlertCenterNotifier() : super(const DrugInteractionAlertCenterModel(isLoading: true));

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

final drug_interaction_alert_centerProvider = StateNotifierProvider<DrugInteractionAlertCenterNotifier, DrugInteractionAlertCenterModel>((ref) {
  return DrugInteractionAlertCenterNotifier()..loadData();
});
