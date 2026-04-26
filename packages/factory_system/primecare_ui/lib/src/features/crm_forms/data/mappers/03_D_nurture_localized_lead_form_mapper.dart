// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_nurture_localized_lead_form_view_model.dart';
import '../dtos/02_M_nurture_localized_lead_form_dto.dart';

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
