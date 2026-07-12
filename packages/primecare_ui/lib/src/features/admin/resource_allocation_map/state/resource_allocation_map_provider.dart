import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/resource_allocation_map_model.dart';

class ResourceAllocationMapNotifier extends StateNotifier<ResourceAllocationMapModel> {
  ResourceAllocationMapNotifier() : super(const ResourceAllocationMapModel(isLoading: true));

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

final resource_allocation_mapProvider = StateNotifierProvider<ResourceAllocationMapNotifier, ResourceAllocationMapModel>((ref) {
  return ResourceAllocationMapNotifier()..loadData();
});
