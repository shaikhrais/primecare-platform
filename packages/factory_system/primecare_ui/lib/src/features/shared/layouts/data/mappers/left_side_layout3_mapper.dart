// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/left_side_layout3_view_model.dart';
import '../dtos/left_side_layout3_dto.dart';

class LeftSideLayout3Mapper {
  static LeftSideLayout3ViewModel fromDto(LeftSideLayout3Dto dto) {
    return LeftSideLayout3ViewModel(
      title: dto.raw['title']?.toString() ?? 'leftSideLayout3',
      metadata: dto.raw,
    );
  }
}
