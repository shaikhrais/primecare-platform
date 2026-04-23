// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_approve_system_access_form_view_model.dart';
import '../dtos/02_M_approve_system_access_form_dto.dart';

class ApproveSystemAccessFormMapper {
  static ApproveSystemAccessFormViewModel fromDto(ApproveSystemAccessFormDto dto) {
    return ApproveSystemAccessFormViewModel(
      title: dto.raw['title']?.toString() ?? 'approveSystemAccessForm',
      metadata: dto.raw,
    );
  }
}

