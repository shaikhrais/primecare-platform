// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/demo_sidebar_content_view_model.dart';
import '../dtos/demo_sidebar_content_dto.dart';

class DemoSidebarContentMapper {
  static DemoSidebarContentViewModel fromDto(DemoSidebarContentDto dto) {
    return DemoSidebarContentViewModel(
      title: dto.raw['title']?.toString() ?? 'demoSidebarContent',
      metadata: dto.raw,
    );
  }
}
