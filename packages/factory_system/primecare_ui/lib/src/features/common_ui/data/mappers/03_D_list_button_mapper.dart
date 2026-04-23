// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_list_button_view_model.dart';
import '../dtos/02_M_list_button_dto.dart';

class ListButtonMapper {
  static ListButtonViewModel fromDto(ListButtonDto dto) {
    return ListButtonViewModel(
      title: dto.raw['title']?.toString() ?? 'listButton',
      metadata: dto.raw,
    );
  }
}

