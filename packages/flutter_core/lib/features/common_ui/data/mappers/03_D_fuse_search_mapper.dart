// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_fuse_search_view_model.dart';
import '../dtos/02_M_fuse_search_dto.dart';

class FuseSearchMapper {
  static FuseSearchViewModel fromDto(FuseSearchDto dto) {
    return FuseSearchViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseSearch',
      metadata: dto.raw,
    );
  }
}

