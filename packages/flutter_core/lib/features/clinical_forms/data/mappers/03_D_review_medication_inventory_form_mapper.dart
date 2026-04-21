// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_review_medication_inventory_form_view_model.dart';
import '../dtos/02_M_review_medication_inventory_form_dto.dart';

class ReviewMedicationInventoryFormMapper {
  static ReviewMedicationInventoryFormViewModel fromDto(ReviewMedicationInventoryFormDto dto) {
    return ReviewMedicationInventoryFormViewModel(
      title: dto.raw['title']?.toString() ?? 'reviewMedicationInventoryForm',
      metadata: dto.raw,
    );
  }
}

