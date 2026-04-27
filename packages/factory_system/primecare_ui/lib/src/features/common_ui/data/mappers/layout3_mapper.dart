// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/layout3_view_model.dart';
import '../dtos/layout3_dto.dart';

class Layout3Mapper {
  static Layout3ViewModel fromDto(Layout3Dto dto) {
    return Layout3ViewModel(
      title: dto.raw['title']?.toString() ?? 'layout3',
      metadata: dto.raw,
    );
  }
}
