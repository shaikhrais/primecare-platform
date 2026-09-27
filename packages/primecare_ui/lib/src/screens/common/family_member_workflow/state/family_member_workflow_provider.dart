import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/family_member_workflow_model.dart';

class FamilyMemberWorkflowNotifier extends StateNotifier<FamilyMemberWorkflowModel> {
  FamilyMemberWorkflowNotifier() : super(const FamilyMemberWorkflowModel(isLoading: true));

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

final family_member_workflowProvider = StateNotifierProvider<FamilyMemberWorkflowNotifier, FamilyMemberWorkflowModel>((ref) {
  return FamilyMemberWorkflowNotifier()..loadData();
});
