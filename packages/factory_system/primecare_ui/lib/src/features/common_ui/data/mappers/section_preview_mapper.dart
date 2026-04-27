// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/section_preview_view_model.dart';
import '../dtos/section_preview_dto.dart';

class SectionPreviewMapper {
  static SectionPreviewViewModel fromDto(SectionPreviewDto dto) {
    return SectionPreviewViewModel(
      title: dto.raw['title']?.toString() ?? 'sectionPreview',
      metadata: dto.raw,
    );
  }
}
