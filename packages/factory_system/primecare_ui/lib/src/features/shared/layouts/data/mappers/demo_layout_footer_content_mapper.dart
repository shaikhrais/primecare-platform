// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/demo_layout_footer_content_view_model.dart';
import '../dtos/demo_layout_footer_content_dto.dart';

class DemoLayoutFooterContentMapper {
  static DemoLayoutFooterContentViewModel fromDto(
    DemoLayoutFooterContentDto dto,
  ) {
    return DemoLayoutFooterContentViewModel(
      title: dto.raw['title']?.toString() ?? 'demoLayoutFooterContent',
      metadata: dto.raw,
    );
  }
}
