import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/biospecimen_inventory_tracker_model.dart';

class BiospecimenInventoryTrackerNotifier extends StateNotifier<BiospecimenInventoryTrackerModel> {
  BiospecimenInventoryTrackerNotifier() : super(const BiospecimenInventoryTrackerModel(isLoading: true));

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

final biospecimen_inventory_trackerProvider = StateNotifierProvider<BiospecimenInventoryTrackerNotifier, BiospecimenInventoryTrackerModel>((ref) {
  return BiospecimenInventoryTrackerNotifier()..loadData();
});
