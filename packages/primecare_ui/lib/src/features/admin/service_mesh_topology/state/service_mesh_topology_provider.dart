import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/service_mesh_topology_model.dart';

class ServiceMeshTopologyNotifier extends StateNotifier<ServiceMeshTopologyModel> {
  ServiceMeshTopologyNotifier() : super(const ServiceMeshTopologyModel(isLoading: true));

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

final service_mesh_topologyProvider = StateNotifierProvider<ServiceMeshTopologyNotifier, ServiceMeshTopologyModel>((ref) {
  return ServiceMeshTopologyNotifier()..loadData();
});
