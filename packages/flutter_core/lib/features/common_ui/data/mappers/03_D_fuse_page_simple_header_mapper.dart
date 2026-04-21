// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_fuse_page_simple_header_view_model.dart';
import '../dtos/02_M_fuse_page_simple_header_dto.dart';

class FusePageSimpleHeaderMapper {
  static FusePageSimpleHeaderViewModel fromDto(FusePageSimpleHeaderDto dto) {
    return FusePageSimpleHeaderViewModel(
      title: dto.raw['title']?.toString() ?? 'fusePageSimpleHeader',
      metadata: dto.raw,
    );
  }
}

