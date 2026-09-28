import 'package:flutter_riverpod/legacy.dart';
import '../models/cto_infrastructure_model.dart';

class CtoInfrastructureNotifier extends StateNotifier<CtoInfrastructureModel> {
  CtoInfrastructureNotifier() : super(const CtoInfrastructureModel(isLoading: true));

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

final cto_infrastructureProvider = StateNotifierProvider<CtoInfrastructureNotifier, CtoInfrastructureModel>((ref) {
  return CtoInfrastructureNotifier()..loadData();
});
