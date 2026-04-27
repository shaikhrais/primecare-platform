// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/franchise_onboarding_checklist_form_view_model.dart';
import '../dtos/franchise_onboarding_checklist_form_dto.dart';

class FranchiseOnboardingChecklistFormMapper {
  static FranchiseOnboardingChecklistFormViewModel toViewModel(
    FranchiseOnboardingChecklistFormDto dto,
  ) {
    return FranchiseOnboardingChecklistFormViewModel(
      isLoading: false,
      isSuccess: true,
      data: dto.rawData,
    );
  }

  static FranchiseOnboardingChecklistFormDto toDto(
    FranchiseOnboardingChecklistFormViewModel viewModel,
  ) {
    return FranchiseOnboardingChecklistFormDto(rawData: viewModel.data);
  }
}
