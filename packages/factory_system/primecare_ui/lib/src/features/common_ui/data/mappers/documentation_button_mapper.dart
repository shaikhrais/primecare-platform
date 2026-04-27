// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/documentation_button_view_model.dart';
import '../dtos/documentation_button_dto.dart';

class DocumentationButtonMapper {
  static DocumentationButtonViewModel fromDto(DocumentationButtonDto dto) {
    return DocumentationButtonViewModel(
      title: dto.raw['title']?.toString() ?? 'documentationButton',
      metadata: dto.raw,
    );
  }
}
