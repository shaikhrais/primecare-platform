import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/chiropractor_command_center_model.dart';

class ChiropractorCommandCenterNotifier extends StateNotifier<ChiropractorCommandCenterModel> {
  ChiropractorCommandCenterNotifier() : super(const ChiropractorCommandCenterModel(isLoading: true));

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

final chiropractor_command_centerProvider = StateNotifierProvider<ChiropractorCommandCenterNotifier, ChiropractorCommandCenterModel>((ref) {
  return ChiropractorCommandCenterNotifier()..loadData();
});
