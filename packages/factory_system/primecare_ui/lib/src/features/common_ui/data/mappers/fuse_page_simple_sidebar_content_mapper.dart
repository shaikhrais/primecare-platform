// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/fuse_page_simple_sidebar_content_view_model.dart';
import '../dtos/fuse_page_simple_sidebar_content_dto.dart';

class FusePageSimpleSidebarContentMapper {
  static FusePageSimpleSidebarContentViewModel fromDto(
    FusePageSimpleSidebarContentDto dto,
  ) {
    return FusePageSimpleSidebarContentViewModel(
      title: dto.raw['title']?.toString() ?? 'fusePageSimpleSidebarContent',
      metadata: dto.raw,
    );
  }
}
