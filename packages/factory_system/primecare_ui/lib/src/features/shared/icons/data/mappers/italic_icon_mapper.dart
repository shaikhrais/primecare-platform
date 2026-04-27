// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/italic_icon_view_model.dart';
import '../dtos/italic_icon_dto.dart';

class ItalicIconMapper {
  static ItalicIconViewModel fromDto(ItalicIconDto dto) {
    return ItalicIconViewModel(
      title: dto.raw['title']?.toString() ?? 'italicIcon',
      metadata: dto.raw,
    );
  }
}
