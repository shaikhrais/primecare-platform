// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_page_breadcrumb_view_model.dart';
import '../dtos/02_M_page_breadcrumb_dto.dart';

class PageBreadcrumbMapper {
  static PageBreadcrumbViewModel fromDto(PageBreadcrumbDto dto) {
    return PageBreadcrumbViewModel(
      title: dto.raw['title']?.toString() ?? 'pageBreadcrumb',
      metadata: dto.raw,
    );
  }
}

