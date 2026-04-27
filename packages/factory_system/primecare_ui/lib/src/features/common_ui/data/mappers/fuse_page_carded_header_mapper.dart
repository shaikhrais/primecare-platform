// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/fuse_page_carded_header_view_model.dart';
import '../dtos/fuse_page_carded_header_dto.dart';

class FusePageCardedHeaderMapper {
  static FusePageCardedHeaderViewModel fromDto(FusePageCardedHeaderDto dto) {
    return FusePageCardedHeaderViewModel(
      title: dto.raw['title']?.toString() ?? 'fusePageCardedHeader',
      metadata: dto.raw,
    );
  }
}
