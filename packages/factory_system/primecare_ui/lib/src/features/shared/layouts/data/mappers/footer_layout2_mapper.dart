// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/footer_layout2_view_model.dart';
import '../dtos/footer_layout2_dto.dart';

class FooterLayout2Mapper {
  static FooterLayout2ViewModel fromDto(FooterLayout2Dto dto) {
    return FooterLayout2ViewModel(
      title: dto.raw['title']?.toString() ?? 'footerLayout2',
      metadata: dto.raw,
    );
  }
}
