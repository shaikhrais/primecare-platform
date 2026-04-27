// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/demo_frame_view_model.dart';
import '../dtos/demo_frame_dto.dart';

class DemoFrameMapper {
  static DemoFrameViewModel fromDto(DemoFrameDto dto) {
    return DemoFrameViewModel(
      title: dto.raw['title']?.toString() ?? 'demoFrame',
      metadata: dto.raw,
    );
  }
}
