// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_framed_demo_view_model.dart';
import '../dtos/02_M_framed_demo_dto.dart';

class FramedDemoMapper {
  static FramedDemoViewModel fromDto(FramedDemoDto dto) {
    return FramedDemoViewModel(
      title: dto.raw['title']?.toString() ?? 'framedDemo',
      metadata: dto.raw,
    );
  }
}

