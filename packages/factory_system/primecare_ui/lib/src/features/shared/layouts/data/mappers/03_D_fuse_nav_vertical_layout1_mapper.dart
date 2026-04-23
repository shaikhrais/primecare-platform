// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_fuse_nav_vertical_layout1_view_model.dart';
import '../dtos/02_M_fuse_nav_vertical_layout1_dto.dart';

class FuseNavVerticalLayout1Mapper {
  static FuseNavVerticalLayout1ViewModel fromDto(FuseNavVerticalLayout1Dto dto) {
    return FuseNavVerticalLayout1ViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseNavVerticalLayout1',
      metadata: dto.raw,
    );
  }
}

