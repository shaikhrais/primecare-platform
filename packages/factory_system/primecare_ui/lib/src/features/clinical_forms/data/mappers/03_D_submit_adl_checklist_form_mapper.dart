// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_submit_adl_checklist_form_view_model.dart';
import '../dtos/02_M_submit_adl_checklist_form_dto.dart';

class SubmitAdlChecklistFormMapper {
  static SubmitAdlChecklistFormViewModel fromDto(
    SubmitAdlChecklistFormDto dto,
  ) {
    return SubmitAdlChecklistFormViewModel(
      title: dto.raw['title']?.toString() ?? 'submitAdlChecklistForm',
      metadata: dto.raw,
    );
  }
}
