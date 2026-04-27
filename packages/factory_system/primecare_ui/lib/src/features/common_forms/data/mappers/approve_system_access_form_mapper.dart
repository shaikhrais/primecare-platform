// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/approve_system_access_form_view_model.dart';
import '../dtos/approve_system_access_form_dto.dart';

class ApproveSystemAccessFormMapper {
  static ApproveSystemAccessFormViewModel fromDto(
    ApproveSystemAccessFormDto dto,
  ) {
    return ApproveSystemAccessFormViewModel(
      title: dto.raw['title']?.toString() ?? 'approveSystemAccessForm',
      metadata: dto.raw,
    );
  }
}
