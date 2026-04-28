// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/fuse_nav_vertical_layout2_view_model.dart';
import '../dtos/fuse_nav_vertical_layout2_dto.dart';

class FuseNavVerticalLayout2Mapper {
  static FuseNavVerticalLayout2ViewModel fromDto(
    FuseNavVerticalLayout2Dto dto,
  ) {
    return FuseNavVerticalLayout2ViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseNavVerticalLayout2',
      metadata: dto.raw,
    );
  }
}
