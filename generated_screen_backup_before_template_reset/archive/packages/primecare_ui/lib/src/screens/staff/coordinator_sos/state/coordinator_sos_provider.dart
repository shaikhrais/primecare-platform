import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/coordinator_sos_model.dart';

class CoordinatorSosNotifier extends StateNotifier<CoordinatorSosModel> {
  CoordinatorSosNotifier() : super(const CoordinatorSosModel(isLoading: true));

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

final coordinator_sosProvider = StateNotifierProvider<CoordinatorSosNotifier, CoordinatorSosModel>((ref) {
  return CoordinatorSosNotifier()..loadData();
});
