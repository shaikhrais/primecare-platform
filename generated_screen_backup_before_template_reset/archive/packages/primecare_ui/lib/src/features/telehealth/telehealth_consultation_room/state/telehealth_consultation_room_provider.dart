import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/telehealth_consultation_room_model.dart';

class TelehealthConsultationRoomNotifier extends StateNotifier<TelehealthConsultationRoomModel> {
  TelehealthConsultationRoomNotifier() : super(const TelehealthConsultationRoomModel(isLoading: true));

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

final telehealth_consultation_roomProvider = StateNotifierProvider<TelehealthConsultationRoomNotifier, TelehealthConsultationRoomModel>((ref) {
  return TelehealthConsultationRoomNotifier()..loadData();
});
