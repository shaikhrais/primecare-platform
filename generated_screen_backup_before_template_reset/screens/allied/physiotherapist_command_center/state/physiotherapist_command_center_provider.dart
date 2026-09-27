import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/physiotherapist_command_center_model.dart';

class PhysiotherapistCommandCenterNotifier extends StateNotifier<PhysiotherapistCommandCenterModel> {
  PhysiotherapistCommandCenterNotifier() : super(const PhysiotherapistCommandCenterModel(isLoading: true));

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

final physiotherapist_command_centerProvider = StateNotifierProvider<PhysiotherapistCommandCenterNotifier, PhysiotherapistCommandCenterModel>((ref) {
  return PhysiotherapistCommandCenterNotifier()..loadData();
});
