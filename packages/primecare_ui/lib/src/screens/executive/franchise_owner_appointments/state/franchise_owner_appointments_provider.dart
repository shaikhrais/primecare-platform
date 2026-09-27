import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/franchise_owner_appointments_model.dart';

class FranchiseOwnerAppointmentsNotifier extends StateNotifier<FranchiseOwnerAppointmentsModel> {
  FranchiseOwnerAppointmentsNotifier() : super(const FranchiseOwnerAppointmentsModel(isLoading: true));

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

final franchise_owner_appointmentsProvider = StateNotifierProvider<FranchiseOwnerAppointmentsNotifier, FranchiseOwnerAppointmentsModel>((ref) {
  return FranchiseOwnerAppointmentsNotifier()..loadData();
});
