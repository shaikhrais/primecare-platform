// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/admin_layout_view_model.dart';
import '../dtos/admin_layout_dto.dart';

class AdminLayoutMapper {
  static AdminLayoutViewModel fromDto(AdminLayoutDto dto) {
    return AdminLayoutViewModel(
      title: dto.raw['title']?.toString() ?? 'adminLayout',
      metadata: dto.raw,
    );
  }
}
