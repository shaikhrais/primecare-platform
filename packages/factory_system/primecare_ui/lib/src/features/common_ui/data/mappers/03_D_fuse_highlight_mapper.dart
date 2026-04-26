// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_fuse_highlight_view_model.dart';
import '../dtos/02_M_fuse_highlight_dto.dart';

class FuseHighlightMapper {
  static FuseHighlightViewModel fromDto(FuseHighlightDto dto) {
    return FuseHighlightViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseHighlight',
      metadata: dto.raw,
    );
  }
}
