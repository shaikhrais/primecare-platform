import 'package:flutter_riverpod/legacy.dart';
import '../models/ticket_center_model.dart';

class TicketCenterNotifier extends StateNotifier<TicketCenterModel> {
  TicketCenterNotifier() : super(const TicketCenterModel(isLoading: true));

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

final ticket_centerProvider = StateNotifierProvider<TicketCenterNotifier, TicketCenterModel>((ref) {
  return TicketCenterNotifier()..loadData();
});
