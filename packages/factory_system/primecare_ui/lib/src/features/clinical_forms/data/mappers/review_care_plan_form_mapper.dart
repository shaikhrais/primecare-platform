// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/review_care_plan_form_view_model.dart';
import '../dtos/review_care_plan_form_dto.dart';

class ReviewCarePlanFormMapper {
  static ReviewCarePlanFormViewModel fromDto(ReviewCarePlanFormDto dto) {
    return ReviewCarePlanFormViewModel(
      title: dto.raw['title']?.toString() ?? 'reviewCarePlanForm',
      metadata: dto.raw,
    );
  }
}
