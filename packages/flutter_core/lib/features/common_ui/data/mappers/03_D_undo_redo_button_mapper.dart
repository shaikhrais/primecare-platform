// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_undo_redo_button_view_model.dart';
import '../dtos/02_M_undo_redo_button_dto.dart';

class UndoRedoButtonMapper {
  static UndoRedoButtonViewModel fromDto(UndoRedoButtonDto dto) {
    return UndoRedoButtonViewModel(
      title: dto.raw['title']?.toString() ?? 'undoRedoButton',
      metadata: dto.raw,
    );
  }
}

