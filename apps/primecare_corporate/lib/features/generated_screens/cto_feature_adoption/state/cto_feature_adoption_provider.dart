import 'package:flutter_riverpod/legacy.dart';
import '../models/cto_feature_adoption_model.dart';

class CtoFeatureAdoptionNotifier extends StateNotifier<CtoFeatureAdoptionModel> {
  CtoFeatureAdoptionNotifier() : super(const CtoFeatureAdoptionModel(isLoading: true));

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

final cto_feature_adoptionProvider = StateNotifierProvider<CtoFeatureAdoptionNotifier, CtoFeatureAdoptionModel>((ref) {
  return CtoFeatureAdoptionNotifier()..loadData();
});
