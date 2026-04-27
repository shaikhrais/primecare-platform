// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/review_legal_contract_form_view_model.dart';
import '../dtos/review_legal_contract_form_dto.dart';

class ReviewLegalContractFormMapper {
  static ReviewLegalContractFormViewModel fromDto(
    ReviewLegalContractFormDto dto,
  ) {
    return ReviewLegalContractFormViewModel(
      title: dto.raw['title']?.toString() ?? 'reviewLegalContractForm',
      metadata: dto.raw,
    );
  }
}
