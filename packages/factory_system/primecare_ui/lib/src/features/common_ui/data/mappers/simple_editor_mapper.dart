// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/simple_editor_view_model.dart';
import '../dtos/simple_editor_dto.dart';

class SimpleEditorMapper {
  static SimpleEditorViewModel fromDto(SimpleEditorDto dto) {
    return SimpleEditorViewModel(
      title: dto.raw['title']?.toString() ?? 'simpleEditor',
      metadata: dto.raw,
    );
  }
}
