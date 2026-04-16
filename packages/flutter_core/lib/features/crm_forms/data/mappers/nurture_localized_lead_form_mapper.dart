import '../../domain/models/nurture_localized_lead_form_view_model.dart';
import '../dtos/nurture_localized_lead_form_dto.dart';

class NurtureLocalizedLeadFormMapper {
  static NurtureLocalizedLeadFormViewModel toViewModel(
    NurtureLocalizedLeadFormDto dto,
  ) {
    return NurtureLocalizedLeadFormViewModel(
      isLoading: false,
      isSuccess: true,
      data: dto.rawData,
    );
  }

  static NurtureLocalizedLeadFormDto toDto(
    NurtureLocalizedLeadFormViewModel viewModel,
  ) {
    return NurtureLocalizedLeadFormDto(rawData: viewModel.data);
  }
}
