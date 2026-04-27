// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/franchise_onboarding_checklist_form_view_model.dart';
import '../dtos/franchise_onboarding_checklist_form_dto.dart';

class FranchiseOnboardingChecklistFormMapper {
  static FranchiseOnboardingChecklistFormViewModel fromDto(
    FranchiseOnboardingChecklistFormDto dto,
  ) {
    return FranchiseOnboardingChecklistFormViewModel(
      title: dto.raw['title']?.toString() ?? 'franchiseOnboardingChecklistForm',
      metadata: dto.raw,
    );
  }
}
