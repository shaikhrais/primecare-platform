// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_toolbar_layout1_view_model.dart';
import '../dtos/02_M_toolbar_layout1_dto.dart';

class ToolbarLayout1Mapper {
  static ToolbarLayout1ViewModel fromDto(ToolbarLayout1Dto dto) {
    return ToolbarLayout1ViewModel(
      title: dto.raw['title']?.toString() ?? 'toolbarLayout1',
      metadata: dto.raw,
    );
  }
}
