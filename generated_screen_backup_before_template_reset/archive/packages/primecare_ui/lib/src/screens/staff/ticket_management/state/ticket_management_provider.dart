import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/ticket_management_model.dart';

class TicketManagementNotifier extends StateNotifier<TicketManagementModel> {
  TicketManagementNotifier() : super(const TicketManagementModel(isLoading: true));

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

final ticket_managementProvider = StateNotifierProvider<TicketManagementNotifier, TicketManagementModel>((ref) {
  return TicketManagementNotifier()..loadData();
});
