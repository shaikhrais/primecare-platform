// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_fuse_svg_icon_view_model.dart';
import '../dtos/02_M_fuse_svg_icon_dto.dart';

class FuseSvgIconMapper {
  static FuseSvgIconViewModel fromDto(FuseSvgIconDto dto) {
    return FuseSvgIconViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseSvgIcon',
      metadata: dto.raw,
    );
  }
}

