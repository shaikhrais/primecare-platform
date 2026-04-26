// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_review_lead_conversion_form_view_model.dart';
import '../dtos/02_M_review_lead_conversion_form_dto.dart';

class ReviewLeadConversionFormMapper {
  static ReviewLeadConversionFormViewModel toViewModel(
    ReviewLeadConversionFormDto dto,
  ) {
    return ReviewLeadConversionFormViewModel(
      isLoading: false,
      isSuccess: true,
      data: dto.rawData,
    );
  }

  static ReviewLeadConversionFormDto toDto(
    ReviewLeadConversionFormViewModel viewModel,
  ) {
    return ReviewLeadConversionFormDto(rawData: viewModel.data);
  }
}
