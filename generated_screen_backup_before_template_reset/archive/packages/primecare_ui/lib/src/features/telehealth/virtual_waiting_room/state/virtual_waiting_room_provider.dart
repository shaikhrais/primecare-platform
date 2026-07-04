import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/virtual_waiting_room_model.dart';

class VirtualWaitingRoomNotifier extends StateNotifier<VirtualWaitingRoomModel> {
  VirtualWaitingRoomNotifier() : super(const VirtualWaitingRoomModel(isLoading: true));

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

final virtual_waiting_roomProvider = StateNotifierProvider<VirtualWaitingRoomNotifier, VirtualWaitingRoomModel>((ref) {
  return VirtualWaitingRoomNotifier()..loadData();
});
