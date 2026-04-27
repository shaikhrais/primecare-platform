// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/title_reference_link_view_model.dart';
import '../dtos/title_reference_link_dto.dart';

class TitleReferenceLinkMapper {
  static TitleReferenceLinkViewModel fromDto(TitleReferenceLinkDto dto) {
    return TitleReferenceLinkViewModel(
      title: dto.raw['title']?.toString() ?? 'titleReferenceLink',
      metadata: dto.raw,
    );
  }
}
