// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/demo_content_view_model.dart';
import '../dtos/demo_content_dto.dart';

class DemoContentMapper {
  static DemoContentViewModel fromDto(DemoContentDto dto) {
    return DemoContentViewModel(
      title: dto.raw['title']?.toString() ?? 'demoContent',
      metadata: dto.raw,
    );
  }
}
