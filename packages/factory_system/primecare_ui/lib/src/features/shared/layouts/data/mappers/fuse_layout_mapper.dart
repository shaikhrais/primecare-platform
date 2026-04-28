// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/fuse_layout_view_model.dart';
import '../dtos/fuse_layout_dto.dart';

class FuseLayoutMapper {
  static FuseLayoutViewModel fromDto(FuseLayoutDto dto) {
    return FuseLayoutViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseLayout',
      metadata: dto.raw,
    );
  }
}
