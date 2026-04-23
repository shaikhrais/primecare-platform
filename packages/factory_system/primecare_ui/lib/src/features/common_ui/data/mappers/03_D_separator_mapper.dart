// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_separator_view_model.dart';
import '../dtos/02_M_separator_dto.dart';

class SeparatorMapper {
  static SeparatorViewModel fromDto(SeparatorDto dto) {
    return SeparatorViewModel(
      title: dto.raw['title']?.toString() ?? 'separator',
      metadata: dto.raw,
    );
  }
}

