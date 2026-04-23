// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_right_side_layout2_view_model.dart';
import '../dtos/02_M_right_side_layout2_dto.dart';

class RightSideLayout2Mapper {
  static RightSideLayout2ViewModel fromDto(RightSideLayout2Dto dto) {
    return RightSideLayout2ViewModel(
      title: dto.raw['title']?.toString() ?? 'rightSideLayout2',
      metadata: dto.raw,
    );
  }
}

