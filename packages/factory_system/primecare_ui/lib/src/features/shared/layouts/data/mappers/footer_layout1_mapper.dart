// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/footer_layout1_view_model.dart';
import '../dtos/footer_layout1_dto.dart';

class FooterLayout1Mapper {
  static FooterLayout1ViewModel fromDto(FooterLayout1Dto dto) {
    return FooterLayout1ViewModel(
      title: dto.raw['title']?.toString() ?? 'footerLayout1',
      metadata: dto.raw,
    );
  }
}
