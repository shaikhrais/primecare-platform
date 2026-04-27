// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/fuse_page_carded_sidebar_content_view_model.dart';
import '../dtos/fuse_page_carded_sidebar_content_dto.dart';

class FusePageCardedSidebarContentMapper {
  static FusePageCardedSidebarContentViewModel fromDto(
    FusePageCardedSidebarContentDto dto,
  ) {
    return FusePageCardedSidebarContentViewModel(
      title: dto.raw['title']?.toString() ?? 'fusePageCardedSidebarContent',
      metadata: dto.raw,
    );
  }
}
