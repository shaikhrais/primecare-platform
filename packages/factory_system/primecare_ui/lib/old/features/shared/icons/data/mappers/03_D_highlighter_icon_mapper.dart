// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_highlighter_icon_view_model.dart';
import '../dtos/02_M_highlighter_icon_dto.dart';

class HighlighterIconMapper {
  static HighlighterIconViewModel fromDto(HighlighterIconDto dto) {
    return HighlighterIconViewModel(
      title: dto.raw['title']?.toString() ?? 'highlighterIcon',
      metadata: dto.raw,
    );
  }
}
