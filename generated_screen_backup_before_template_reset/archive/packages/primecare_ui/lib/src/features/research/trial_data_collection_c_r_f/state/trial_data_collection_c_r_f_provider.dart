import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/trial_data_collection_c_r_f_model.dart';

class TrialDataCollectionCRFNotifier extends StateNotifier<TrialDataCollectionCRFModel> {
  TrialDataCollectionCRFNotifier() : super(const TrialDataCollectionCRFModel(isLoading: true));

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

final trial_data_collection_c_r_fProvider = StateNotifierProvider<TrialDataCollectionCRFNotifier, TrialDataCollectionCRFModel>((ref) {
  return TrialDataCollectionCRFNotifier()..loadData();
});
