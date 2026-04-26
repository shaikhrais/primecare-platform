// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_left_side_layout2_view_model.dart';
import '../dtos/02_M_left_side_layout2_dto.dart';

class LeftSideLayout2Mapper {
  static LeftSideLayout2ViewModel fromDto(LeftSideLayout2Dto dto) {
    return LeftSideLayout2ViewModel(
      title: dto.raw['title']?.toString() ?? 'leftSideLayout2',
      metadata: dto.raw,
    );
  }
}
