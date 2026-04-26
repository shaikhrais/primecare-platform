// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_demo_frame_view_model.dart';
import '../dtos/02_M_demo_frame_dto.dart';

class DemoFrameMapper {
  static DemoFrameViewModel fromDto(DemoFrameDto dto) {
    return DemoFrameViewModel(
      title: dto.raw['title']?.toString() ?? 'demoFrame',
      metadata: dto.raw,
    );
  }
}
