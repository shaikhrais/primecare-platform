// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_use_pathname_view_model.dart';
import '../dtos/02_M_use_pathname_dto.dart';

class UsePathnameMapper {
  static UsePathnameViewModel fromDto(UsePathnameDto dto) {
    return UsePathnameViewModel(
      title: dto.raw['title']?.toString() ?? 'usePathname',
      metadata: dto.raw,
    );
  }
}

