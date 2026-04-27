// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/undo2_icon_view_model.dart';
import '../dtos/undo2_icon_dto.dart';

class Undo2IconMapper {
  static Undo2IconViewModel fromDto(Undo2IconDto dto) {
    return Undo2IconViewModel(
      title: dto.raw['title']?.toString() ?? 'undo2Icon',
      metadata: dto.raw,
    );
  }
}
