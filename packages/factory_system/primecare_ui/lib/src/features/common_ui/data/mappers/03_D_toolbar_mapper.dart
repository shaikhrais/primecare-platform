// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_toolbar_view_model.dart';
import '../dtos/02_M_toolbar_dto.dart';

class ToolbarMapper {
  static ToolbarViewModel fromDto(ToolbarDto dto) {
    return ToolbarViewModel(
      title: dto.raw['title']?.toString() ?? 'toolbar',
      metadata: dto.raw,
    );
  }
}
