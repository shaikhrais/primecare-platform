// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_fuse_page_carded_sidebar_view_model.dart';
import '../dtos/02_M_fuse_page_carded_sidebar_dto.dart';

class FusePageCardedSidebarMapper {
  static FusePageCardedSidebarViewModel fromDto(FusePageCardedSidebarDto dto) {
    return FusePageCardedSidebarViewModel(
      title: dto.raw['title']?.toString() ?? 'fusePageCardedSidebar',
      metadata: dto.raw,
    );
  }
}
