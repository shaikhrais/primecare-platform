// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_right_side_layout3_view_model.dart';
import '../dtos/02_M_right_side_layout3_dto.dart';

class RightSideLayout3Mapper {
  static RightSideLayout3ViewModel fromDto(RightSideLayout3Dto dto) {
    return RightSideLayout3ViewModel(
      title: dto.raw['title']?.toString() ?? 'rightSideLayout3',
      metadata: dto.raw,
    );
  }
}
