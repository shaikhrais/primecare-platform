// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_footer_layout3_view_model.dart';
import '../dtos/02_M_footer_layout3_dto.dart';

class FooterLayout3Mapper {
  static FooterLayout3ViewModel fromDto(FooterLayout3Dto dto) {
    return FooterLayout3ViewModel(
      title: dto.raw['title']?.toString() ?? 'footerLayout3',
      metadata: dto.raw,
    );
  }
}

