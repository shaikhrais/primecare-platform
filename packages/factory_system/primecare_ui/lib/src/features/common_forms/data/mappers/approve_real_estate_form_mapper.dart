// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/approve_real_estate_form_view_model.dart';
import '../dtos/approve_real_estate_form_dto.dart';

class ApproveRealEstateFormMapper {
  static ApproveRealEstateFormViewModel fromDto(ApproveRealEstateFormDto dto) {
    return ApproveRealEstateFormViewModel(
      title: dto.raw['title']?.toString() ?? 'approveRealEstateForm',
      metadata: dto.raw,
    );
  }
}
