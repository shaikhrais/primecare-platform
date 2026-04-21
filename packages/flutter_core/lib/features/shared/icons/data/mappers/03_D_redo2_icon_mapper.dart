// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_redo2_icon_view_model.dart';
import '../dtos/02_M_redo2_icon_dto.dart';

class Redo2IconMapper {
  static Redo2IconViewModel fromDto(Redo2IconDto dto) {
    return Redo2IconViewModel(
      title: dto.raw['title']?.toString() ?? 'redo2Icon',
      metadata: dto.raw,
    );
  }
}

