import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/receptionist_visitors_model.dart';

class ReceptionistVisitorsNotifier extends StateNotifier<ReceptionistVisitorsModel> {
  ReceptionistVisitorsNotifier() : super(const ReceptionistVisitorsModel(isLoading: true));

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

final receptionist_visitorsProvider = StateNotifierProvider<ReceptionistVisitorsNotifier, ReceptionistVisitorsModel>((ref) {
  return ReceptionistVisitorsNotifier()..loadData();
});
