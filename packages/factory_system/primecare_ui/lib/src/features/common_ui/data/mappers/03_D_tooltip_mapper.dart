// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_tooltip_view_model.dart';
import '../dtos/02_M_tooltip_dto.dart';

class TooltipMapper {
  static TooltipViewModel fromDto(TooltipDto dto) {
    return TooltipViewModel(
      title: dto.raw['title']?.toString() ?? 'tooltip',
      metadata: dto.raw,
    );
  }
}
