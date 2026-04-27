// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/page_title_view_model.dart';
import '../dtos/page_title_dto.dart';

class PageTitleMapper {
  static PageTitleViewModel fromDto(PageTitleDto dto) {
    return PageTitleViewModel(
      title: dto.raw['title']?.toString() ?? 'pageTitle',
      metadata: dto.raw,
    );
  }
}
