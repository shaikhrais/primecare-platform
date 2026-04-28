// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/superscript_icon_view_model.dart';
import '../dtos/superscript_icon_dto.dart';

class SuperscriptIconMapper {
  static SuperscriptIconViewModel fromDto(SuperscriptIconDto dto) {
    return SuperscriptIconViewModel(
      title: dto.raw['title']?.toString() ?? 'superscriptIcon',
      metadata: dto.raw,
    );
  }
}
