// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/toolbar_view_model.dart';
import '../dtos/toolbar_dto.dart';

class ToolbarMapper {
  static ToolbarViewModel fromDto(ToolbarDto dto) {
    return ToolbarViewModel(
      title: dto.raw['title']?.toString() ?? 'toolbar',
      metadata: dto.raw,
    );
  }
}
