// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_error401_page_view_view_model.dart';
import '../dtos/02_M_error401_page_view_dto.dart';

class Error401PageViewMapper {
  static Error401PageViewViewModel fromDto(Error401PageViewDto dto) {
    return Error401PageViewViewModel(
      title: dto.raw['title']?.toString() ?? 'error401PageView',
      metadata: dto.raw,
    );
  }
}
