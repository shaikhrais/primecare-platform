// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/scheme_preview_view_model.dart';
import '../dtos/scheme_preview_dto.dart';

class SchemePreviewMapper {
  static SchemePreviewViewModel fromDto(SchemePreviewDto dto) {
    return SchemePreviewViewModel(
      title: dto.raw['title']?.toString() ?? 'schemePreview',
      metadata: dto.raw,
    );
  }
}
