// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/fuse_scrollbars_view_model.dart';
import '../dtos/fuse_scrollbars_dto.dart';

class FuseScrollbarsMapper {
  static FuseScrollbarsViewModel fromDto(FuseScrollbarsDto dto) {
    return FuseScrollbarsViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseScrollbars',
      metadata: dto.raw,
    );
  }
}
