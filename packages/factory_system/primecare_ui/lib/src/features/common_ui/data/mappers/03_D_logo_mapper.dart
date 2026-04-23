// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_logo_view_model.dart';
import '../dtos/02_M_logo_dto.dart';

class LogoMapper {
  static LogoViewModel fromDto(LogoDto dto) {
    return LogoViewModel(
      title: dto.raw['title']?.toString() ?? 'logo',
      metadata: dto.raw,
    );
  }
}

