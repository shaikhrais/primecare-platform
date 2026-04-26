// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_index_form_view_model.dart';
import '../dtos/02_M_index_form_dto.dart';

class IndexFormMapper {
  static IndexFormViewModel fromDto(IndexFormDto dto) {
    return IndexFormViewModel(
      title: dto.raw['title']?.toString() ?? 'indexForm',
      metadata: dto.raw,
    );
  }
}
