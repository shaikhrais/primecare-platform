// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/right_side_layout1_view_model.dart';
import '../dtos/right_side_layout1_dto.dart';

class RightSideLayout1Mapper {
  static RightSideLayout1ViewModel fromDto(RightSideLayout1Dto dto) {
    return RightSideLayout1ViewModel(
      title: dto.raw['title']?.toString() ?? 'rightSideLayout1',
      metadata: dto.raw,
    );
  }
}
