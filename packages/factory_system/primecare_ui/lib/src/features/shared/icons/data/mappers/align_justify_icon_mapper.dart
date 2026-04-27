// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/align_justify_icon_view_model.dart';
import '../dtos/align_justify_icon_dto.dart';

class AlignJustifyIconMapper {
  static AlignJustifyIconViewModel fromDto(AlignJustifyIconDto dto) {
    return AlignJustifyIconViewModel(
      title: dto.raw['title']?.toString() ?? 'alignJustifyIcon',
      metadata: dto.raw,
    );
  }
}
