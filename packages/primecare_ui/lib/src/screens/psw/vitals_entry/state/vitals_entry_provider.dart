import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/vitals_entry_model.dart';

class VitalsEntryNotifier extends StateNotifier<VitalsEntryModel> {
  VitalsEntryNotifier() : super(const VitalsEntryModel(isLoading: true));

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

final vitals_entryProvider = StateNotifierProvider<VitalsEntryNotifier, VitalsEntryModel>((ref) {
  return VitalsEntryNotifier()..loadData();
});
