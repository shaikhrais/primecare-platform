// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_page_title_view_model.dart';
import '../dtos/02_M_page_title_dto.dart';

class PageTitleMapper {
  static PageTitleViewModel fromDto(PageTitleDto dto) {
    return PageTitleViewModel(
      title: dto.raw['title']?.toString() ?? 'pageTitle',
      metadata: dto.raw,
    );
  }
}

