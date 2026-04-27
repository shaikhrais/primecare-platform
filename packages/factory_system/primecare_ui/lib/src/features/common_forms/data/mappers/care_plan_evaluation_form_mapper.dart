// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/care_plan_evaluation_form_view_model.dart';
import '../dtos/care_plan_evaluation_form_dto.dart';

class CarePlanEvaluationFormMapper {
  static CarePlanEvaluationFormViewModel fromDto(
    CarePlanEvaluationFormDto dto,
  ) {
    return CarePlanEvaluationFormViewModel(
      title: dto.raw['title']?.toString() ?? 'carePlanEvaluationForm',
      metadata: dto.raw,
    );
  }
}
