// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/use_pathname_view_model.dart';
import '../dtos/use_pathname_dto.dart';

class UsePathnameMapper {
  static UsePathnameViewModel fromDto(UsePathnameDto dto) {
    return UsePathnameViewModel(
      title: dto.raw['title']?.toString() ?? 'usePathname',
      metadata: dto.raw,
    );
  }
}
