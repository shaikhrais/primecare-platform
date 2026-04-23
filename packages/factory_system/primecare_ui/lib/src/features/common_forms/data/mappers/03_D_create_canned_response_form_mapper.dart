// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_create_canned_response_form_view_model.dart';
import '../dtos/02_M_create_canned_response_form_dto.dart';

class CreateCannedResponseFormMapper {
  static CreateCannedResponseFormViewModel fromDto(CreateCannedResponseFormDto dto) {
    return CreateCannedResponseFormViewModel(
      title: dto.raw['title']?.toString() ?? 'createCannedResponseForm',
      metadata: dto.raw,
    );
  }
}

