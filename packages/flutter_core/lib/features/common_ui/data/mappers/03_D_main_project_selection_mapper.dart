// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_main_project_selection_view_model.dart';
import '../dtos/02_M_main_project_selection_dto.dart';

class MainProjectSelectionMapper {
  static MainProjectSelectionViewModel fromDto(MainProjectSelectionDto dto) {
    return MainProjectSelectionViewModel(
      title: dto.raw['title']?.toString() ?? 'mainProjectSelection',
      metadata: dto.raw,
    );
  }
}

