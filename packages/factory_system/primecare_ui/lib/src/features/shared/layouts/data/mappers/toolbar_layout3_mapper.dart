// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/toolbar_layout3_view_model.dart';
import '../dtos/toolbar_layout3_dto.dart';

class ToolbarLayout3Mapper {
  static ToolbarLayout3ViewModel fromDto(ToolbarLayout3Dto dto) {
    return ToolbarLayout3ViewModel(
      title: dto.raw['title']?.toString() ?? 'toolbarLayout3',
      metadata: dto.raw,
    );
  }
}
