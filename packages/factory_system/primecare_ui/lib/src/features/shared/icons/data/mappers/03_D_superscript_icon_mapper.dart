// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_superscript_icon_view_model.dart';
import '../dtos/02_M_superscript_icon_dto.dart';

class SuperscriptIconMapper {
  static SuperscriptIconViewModel fromDto(SuperscriptIconDto dto) {
    return SuperscriptIconViewModel(
      title: dto.raw['title']?.toString() ?? 'superscriptIcon',
      metadata: dto.raw,
    );
  }
}

