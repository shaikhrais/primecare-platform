// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/submit_healthcare_claim_form_view_model.dart';
import '../dtos/submit_healthcare_claim_form_dto.dart';

class SubmitHealthcareClaimFormMapper {
  static SubmitHealthcareClaimFormViewModel fromDto(
    SubmitHealthcareClaimFormDto dto,
  ) {
    return SubmitHealthcareClaimFormViewModel(
      title: dto.raw['title']?.toString() ?? 'submitHealthcareClaimForm',
      metadata: dto.raw,
    );
  }
}
