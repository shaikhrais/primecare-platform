import '../../domain/models/review_onboarding_status_form_view_model.dart';
import '../dtos/review_onboarding_status_form_dto.dart';

class ReviewOnboardingStatusFormMapper {
  static ReviewOnboardingStatusFormViewModel toViewModel(
    ReviewOnboardingStatusFormDto dto,
  ) {
    return ReviewOnboardingStatusFormViewModel(
      isLoading: false,
      isSuccess: true,
      data: dto.rawData,
    );
  }

  static ReviewOnboardingStatusFormDto toDto(
    ReviewOnboardingStatusFormViewModel viewModel,
  ) {
    return ReviewOnboardingStatusFormDto(rawData: viewModel.data);
  }
}
