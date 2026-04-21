// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_toolbar_layout2_view_model.dart';
import '../dtos/02_M_toolbar_layout2_dto.dart';

class ToolbarLayout2Mapper {
  static ToolbarLayout2ViewModel fromDto(ToolbarLayout2Dto dto) {
    return ToolbarLayout2ViewModel(
      title: dto.raw['title']?.toString() ?? 'toolbarLayout2',
      metadata: dto.raw,
    );
  }
}
