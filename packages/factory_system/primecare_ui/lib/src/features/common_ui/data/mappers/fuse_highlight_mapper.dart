// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/fuse_highlight_view_model.dart';
import '../dtos/fuse_highlight_dto.dart';

class FuseHighlightMapper {
  static FuseHighlightViewModel fromDto(FuseHighlightDto dto) {
    return FuseHighlightViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseHighlight',
      metadata: dto.raw,
    );
  }
}
