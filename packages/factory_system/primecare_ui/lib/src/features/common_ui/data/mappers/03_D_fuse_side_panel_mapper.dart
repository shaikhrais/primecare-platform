// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_fuse_side_panel_view_model.dart';
import '../dtos/02_M_fuse_side_panel_dto.dart';

class FuseSidePanelMapper {
  static FuseSidePanelViewModel fromDto(FuseSidePanelDto dto) {
    return FuseSidePanelViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseSidePanel',
      metadata: dto.raw,
    );
  }
}
