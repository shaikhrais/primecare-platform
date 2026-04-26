// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_go_to_doc_box_view_model.dart';
import '../dtos/02_M_go_to_doc_box_dto.dart';

class GoToDocBoxMapper {
  static GoToDocBoxViewModel fromDto(GoToDocBoxDto dto) {
    return GoToDocBoxViewModel(
      title: dto.raw['title']?.toString() ?? 'goToDocBox',
      metadata: dto.raw,
    );
  }
}
