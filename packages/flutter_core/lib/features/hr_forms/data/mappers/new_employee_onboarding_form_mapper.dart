import '../../domain/models/new_employee_onboarding_form_view_model.dart';
import '../dtos/new_employee_onboarding_form_dto.dart';

class NewEmployeeOnboardingFormMapper {
  static NewEmployeeOnboardingFormViewModel toViewModel(NewEmployeeOnboardingFormDto dto) {
    return NewEmployeeOnboardingFormViewModel(
      isLoading: false,
      isSuccess: true,
      data: dto.rawData,
    );
  }

  static NewEmployeeOnboardingFormDto toDto(NewEmployeeOnboardingFormViewModel viewModel) {
    return NewEmployeeOnboardingFormDto(
      rawData: viewModel.data,
    );
  }
}
