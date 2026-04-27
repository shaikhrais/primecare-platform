// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/redo2_icon_view_model.dart';
import '../dtos/redo2_icon_dto.dart';

class Redo2IconMapper {
  static Redo2IconViewModel fromDto(Redo2IconDto dto) {
    return Redo2IconViewModel(
      title: dto.raw['title']?.toString() ?? 'redo2Icon',
      metadata: dto.raw,
    );
  }
}
