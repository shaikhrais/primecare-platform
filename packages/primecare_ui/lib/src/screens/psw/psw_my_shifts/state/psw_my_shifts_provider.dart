import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/psw_my_shifts_model.dart';

class PswMyShiftsNotifier extends StateNotifier<PswMyShiftsModel> {
  PswMyShiftsNotifier() : super(const PswMyShiftsModel(isLoading: true));

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

final psw_my_shiftsProvider = StateNotifierProvider<PswMyShiftsNotifier, PswMyShiftsModel>((ref) {
  return PswMyShiftsNotifier()..loadData();
});
