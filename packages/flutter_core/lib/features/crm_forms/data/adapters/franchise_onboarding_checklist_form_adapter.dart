import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/franchise_onboarding_checklist_form_view_model.dart';
import '../mappers/franchise_onboarding_checklist_form_mapper.dart';

class FranchiseOnboardingChecklistFormAdapter extends Notifier<FranchiseOnboardingChecklistFormViewModel> {
  @override
  FranchiseOnboardingChecklistFormViewModel build() {
    return FranchiseOnboardingChecklistFormViewModel();
  }

  void updateData(Map<String, dynamic> newData) {
    state = state.copyWith(data: {...state.data, ...newData});
  }

  Future<void> submit() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      // API call simulated
      await Future.delayed(const Duration(seconds: 1));
      
      final dto = FranchiseOnboardingChecklistFormMapper.toDto(state);
      // ignore: avoid_print
      print('Submitting onboarding checklist: ${dto.toJson()}');
      
      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      // ignore: avoid_print
      print('Error submitting onboarding checklist: \$e');
    }
  }
}

final franchiseOnboardingChecklistFormAdapterProvider =
    NotifierProvider<FranchiseOnboardingChecklistFormAdapter, FranchiseOnboardingChecklistFormViewModel>(() {
  return FranchiseOnboardingChecklistFormAdapter();
});
