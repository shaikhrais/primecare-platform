// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_fuse_page_simple_sidebar_content_view_model.dart';
import '../dtos/02_M_fuse_page_simple_sidebar_content_dto.dart';

class FusePageSimpleSidebarContentMapper {
  static FusePageSimpleSidebarContentViewModel fromDto(FusePageSimpleSidebarContentDto dto) {
    return FusePageSimpleSidebarContentViewModel(
      title: dto.raw['title']?.toString() ?? 'fusePageSimpleSidebarContent',
      metadata: dto.raw,
    );
  }
}

