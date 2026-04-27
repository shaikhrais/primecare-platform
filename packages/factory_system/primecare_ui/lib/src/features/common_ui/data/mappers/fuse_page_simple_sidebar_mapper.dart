// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/fuse_page_simple_sidebar_view_model.dart';
import '../dtos/fuse_page_simple_sidebar_dto.dart';

class FusePageSimpleSidebarMapper {
  static FusePageSimpleSidebarViewModel fromDto(FusePageSimpleSidebarDto dto) {
    return FusePageSimpleSidebarViewModel(
      title: dto.raw['title']?.toString() ?? 'fusePageSimpleSidebar',
      metadata: dto.raw,
    );
  }
}
