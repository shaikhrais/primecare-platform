// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/left_side_layout2_view_model.dart';
import '../dtos/left_side_layout2_dto.dart';

class LeftSideLayout2Mapper {
  static LeftSideLayout2ViewModel fromDto(LeftSideLayout2Dto dto) {
    return LeftSideLayout2ViewModel(
      title: dto.raw['title']?.toString() ?? 'leftSideLayout2',
      metadata: dto.raw,
    );
  }
}
