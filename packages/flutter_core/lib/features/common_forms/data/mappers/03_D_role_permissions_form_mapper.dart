// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_role_permissions_form_view_model.dart';
import '../dtos/02_M_role_permissions_form_dto.dart';

class RolePermissionsFormMapper {
  static RolePermissionsFormViewModel fromDto(RolePermissionsFormDto dto) {
    return RolePermissionsFormViewModel(
      title: dto.raw['title']?.toString() ?? 'rolePermissionsForm',
      metadata: dto.raw,
    );
  }
}

