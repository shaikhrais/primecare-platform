// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_code2_icon_view_model.dart';
import '../dtos/02_M_code2_icon_dto.dart';

class Code2IconMapper {
  static Code2IconViewModel fromDto(Code2IconDto dto) {
    return Code2IconViewModel(
      title: dto.raw['title']?.toString() ?? 'code2Icon',
      metadata: dto.raw,
    );
  }
}

