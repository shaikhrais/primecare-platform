// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/layout2_view_model.dart';
import '../dtos/layout2_dto.dart';

class Layout2Mapper {
  static Layout2ViewModel fromDto(Layout2Dto dto) {
    return Layout2ViewModel(
      title: dto.raw['title']?.toString() ?? 'layout2',
      metadata: dto.raw,
    );
  }
}
