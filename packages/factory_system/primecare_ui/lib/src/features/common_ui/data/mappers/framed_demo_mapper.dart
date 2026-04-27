// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/framed_demo_view_model.dart';
import '../dtos/framed_demo_dto.dart';

class FramedDemoMapper {
  static FramedDemoViewModel fromDto(FramedDemoDto dto) {
    return FramedDemoViewModel(
      title: dto.raw['title']?.toString() ?? 'framedDemo',
      metadata: dto.raw,
    );
  }
}
