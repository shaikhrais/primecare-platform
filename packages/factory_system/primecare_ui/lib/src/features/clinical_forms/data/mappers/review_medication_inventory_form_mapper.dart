// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/review_medication_inventory_form_view_model.dart';
import '../dtos/review_medication_inventory_form_dto.dart';

class ReviewMedicationInventoryFormMapper {
  static ReviewMedicationInventoryFormViewModel fromDto(
    ReviewMedicationInventoryFormDto dto,
  ) {
    return ReviewMedicationInventoryFormViewModel(
      title: dto.raw['title']?.toString() ?? 'reviewMedicationInventoryForm',
      metadata: dto.raw,
    );
  }
}
