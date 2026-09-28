import 'package:flutter_riverpod/legacy.dart';
import '../models/psw_visit_checklist_model.dart';

class PswVisitChecklistNotifier extends StateNotifier<PswVisitChecklistModel> {
  PswVisitChecklistNotifier() : super(const PswVisitChecklistModel(isLoading: true));

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

final psw_visit_checklistProvider = StateNotifierProvider<PswVisitChecklistNotifier, PswVisitChecklistModel>((ref) {
  return PswVisitChecklistNotifier()..loadData();
});
