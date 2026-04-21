// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_review_vendor_contracts_form_view_model.dart';
import '../dtos/02_M_review_vendor_contracts_form_dto.dart';

class ReviewVendorContractsFormMapper {
  static ReviewVendorContractsFormViewModel fromDto(ReviewVendorContractsFormDto dto) {
    return ReviewVendorContractsFormViewModel(
      title: dto.raw['title']?.toString() ?? 'reviewVendorContractsForm',
      metadata: dto.raw,
    );
  }
}

