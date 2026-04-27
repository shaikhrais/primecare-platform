// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/review_onboarding_status_form_view_model.dart';
import '../dtos/review_onboarding_status_form_dto.dart';

class ReviewOnboardingStatusFormMapper {
  static ReviewOnboardingStatusFormViewModel fromDto(
    ReviewOnboardingStatusFormDto dto,
  ) {
    return ReviewOnboardingStatusFormViewModel(
      title: dto.raw['title']?.toString() ?? 'reviewOnboardingStatusForm',
      metadata: dto.raw,
    );
  }
}
