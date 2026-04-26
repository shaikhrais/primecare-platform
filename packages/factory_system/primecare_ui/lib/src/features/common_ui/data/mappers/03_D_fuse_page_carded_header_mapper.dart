// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_fuse_page_carded_header_view_model.dart';
import '../dtos/02_M_fuse_page_carded_header_dto.dart';

class FusePageCardedHeaderMapper {
  static FusePageCardedHeaderViewModel fromDto(FusePageCardedHeaderDto dto) {
    return FusePageCardedHeaderViewModel(
      title: dto.raw['title']?.toString() ?? 'fusePageCardedHeader',
      metadata: dto.raw,
    );
  }
}
