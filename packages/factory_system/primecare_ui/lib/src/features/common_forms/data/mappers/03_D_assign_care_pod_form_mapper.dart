// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_assign_care_pod_form_view_model.dart';
import '../dtos/02_M_assign_care_pod_form_dto.dart';

class AssignCarePodFormMapper {
  static AssignCarePodFormViewModel fromDto(AssignCarePodFormDto dto) {
    return AssignCarePodFormViewModel(
      title: dto.raw['title']?.toString() ?? 'assignCarePodForm',
      metadata: dto.raw,
    );
  }
}

