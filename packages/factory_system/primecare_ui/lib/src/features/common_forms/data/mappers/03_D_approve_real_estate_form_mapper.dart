// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_approve_real_estate_form_view_model.dart';
import '../dtos/02_M_approve_real_estate_form_dto.dart';

class ApproveRealEstateFormMapper {
  static ApproveRealEstateFormViewModel fromDto(ApproveRealEstateFormDto dto) {
    return ApproveRealEstateFormViewModel(
      title: dto.raw['title']?.toString() ?? 'approveRealEstateForm',
      metadata: dto.raw,
    );
  }
}
