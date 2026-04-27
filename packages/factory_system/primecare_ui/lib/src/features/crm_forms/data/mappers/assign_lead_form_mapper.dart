// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/assign_lead_form_view_model.dart';
import '../dtos/assign_lead_form_dto.dart';

class AssignLeadFormMapper {
  static AssignLeadFormViewModel fromDto(AssignLeadFormDto dto) {
    return AssignLeadFormViewModel(
      assignmentId: dto.id ?? '',
      leadId: dto.leadId ?? '',
      assignedToId: dto.assignedToId ?? '',
      priority: dto.priority ?? 'Medium',
      notes: dto.notes ?? '',
    );
  }

  static AssignLeadFormDto toDto(AssignLeadFormViewModel model) {
    return AssignLeadFormDto(
      id: model.assignmentId.isEmpty ? null : model.assignmentId,
      leadId: model.leadId,
      assignedToId: model.assignedToId,
      priority: model.priority,
      notes: model.notes,
    );
  }
}
