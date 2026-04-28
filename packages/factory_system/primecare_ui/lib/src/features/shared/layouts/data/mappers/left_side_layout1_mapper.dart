// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/left_side_layout1_view_model.dart';
import '../dtos/left_side_layout1_dto.dart';

class LeftSideLayout1Mapper {
  static LeftSideLayout1ViewModel fromDto(LeftSideLayout1Dto dto) {
    return LeftSideLayout1ViewModel(
      title: dto.raw['title']?.toString() ?? 'leftSideLayout1',
      metadata: dto.raw,
    );
  }
}
