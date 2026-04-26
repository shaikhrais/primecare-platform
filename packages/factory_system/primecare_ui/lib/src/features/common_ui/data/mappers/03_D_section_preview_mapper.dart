// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_section_preview_view_model.dart';
import '../dtos/02_M_section_preview_dto.dart';

class SectionPreviewMapper {
  static SectionPreviewViewModel fromDto(SectionPreviewDto dto) {
    return SectionPreviewViewModel(
      title: dto.raw['title']?.toString() ?? 'sectionPreview',
      metadata: dto.raw,
    );
  }
}
