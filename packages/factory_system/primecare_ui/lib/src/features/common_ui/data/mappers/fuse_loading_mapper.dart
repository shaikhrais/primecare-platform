// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/fuse_loading_view_model.dart';
import '../dtos/fuse_loading_dto.dart';

class FuseLoadingMapper {
  static FuseLoadingViewModel fromDto(FuseLoadingDto dto) {
    return FuseLoadingViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseLoading',
      metadata: dto.raw,
    );
  }
}
