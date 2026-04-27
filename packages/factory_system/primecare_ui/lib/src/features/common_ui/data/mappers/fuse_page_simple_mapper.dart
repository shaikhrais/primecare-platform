// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/fuse_page_simple_view_model.dart';
import '../dtos/fuse_page_simple_dto.dart';

class FusePageSimpleMapper {
  static FusePageSimpleViewModel fromDto(FusePageSimpleDto dto) {
    return FusePageSimpleViewModel(
      title: dto.raw['title']?.toString() ?? 'fusePageSimple',
      metadata: dto.raw,
    );
  }
}
