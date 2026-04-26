// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_fuse_page_simple_sidebar_view_model.dart';
import '../dtos/02_M_fuse_page_simple_sidebar_dto.dart';

class FusePageSimpleSidebarMapper {
  static FusePageSimpleSidebarViewModel fromDto(FusePageSimpleSidebarDto dto) {
    return FusePageSimpleSidebarViewModel(
      title: dto.raw['title']?.toString() ?? 'fusePageSimpleSidebar',
      metadata: dto.raw,
    );
  }
}
