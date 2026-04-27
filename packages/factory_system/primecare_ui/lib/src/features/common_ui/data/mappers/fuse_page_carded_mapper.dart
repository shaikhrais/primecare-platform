// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/fuse_page_carded_view_model.dart';
import '../dtos/fuse_page_carded_dto.dart';

class FusePageCardedMapper {
  static FusePageCardedViewModel fromDto(FusePageCardedDto dto) {
    return FusePageCardedViewModel(
      title: dto.raw['title']?.toString() ?? 'fusePageCarded',
      metadata: dto.raw,
    );
  }
}
