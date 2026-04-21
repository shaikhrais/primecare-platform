// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_error404_page_view_view_model.dart';
import '../dtos/02_M_error404_page_view_dto.dart';

class Error404PageViewMapper {
  static Error404PageViewViewModel fromDto(Error404PageViewDto dto) {
    return Error404PageViewViewModel(
      title: dto.raw['title']?.toString() ?? 'error404PageView',
      metadata: dto.raw,
    );
  }
}

