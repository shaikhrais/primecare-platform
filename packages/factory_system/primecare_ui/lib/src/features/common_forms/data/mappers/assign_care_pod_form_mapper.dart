// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/assign_care_pod_form_view_model.dart';
import '../dtos/assign_care_pod_form_dto.dart';

class AssignCarePodFormMapper {
  static AssignCarePodFormViewModel fromDto(AssignCarePodFormDto dto) {
    return AssignCarePodFormViewModel(
      title: dto.raw['title']?.toString() ?? 'assignCarePodForm',
      metadata: dto.raw,
    );
  }
}
