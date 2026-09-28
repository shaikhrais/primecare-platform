import 'package:flutter_riverpod/legacy.dart';
import '../models/ceo_strategic_kpis_model.dart';

class CeoStrategicKpisNotifier extends StateNotifier<CeoStrategicKpisModel> {
  CeoStrategicKpisNotifier() : super(const CeoStrategicKpisModel(isLoading: true));

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

final ceo_strategic_kpisProvider = StateNotifierProvider<CeoStrategicKpisNotifier, CeoStrategicKpisModel>((ref) {
  return CeoStrategicKpisNotifier()..loadData();
});
