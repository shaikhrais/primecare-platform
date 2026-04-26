// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_italic_icon_view_model.dart';
import '../dtos/02_M_italic_icon_dto.dart';

class ItalicIconMapper {
  static ItalicIconViewModel fromDto(ItalicIconDto dto) {
    return ItalicIconViewModel(
      title: dto.raw['title']?.toString() ?? 'italicIcon',
      metadata: dto.raw,
    );
  }
}
