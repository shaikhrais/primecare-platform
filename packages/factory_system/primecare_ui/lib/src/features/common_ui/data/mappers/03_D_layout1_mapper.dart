// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_layout1_view_model.dart';
import '../dtos/02_M_layout1_dto.dart';

class Layout1Mapper {
  static Layout1ViewModel fromDto(Layout1Dto dto) {
    return Layout1ViewModel(
      title: dto.raw['title']?.toString() ?? 'layout1',
      metadata: dto.raw,
    );
  }
}

