// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/fuse_nav_horizontal_layout1_view_model.dart';
import '../dtos/fuse_nav_horizontal_layout1_dto.dart';

class FuseNavHorizontalLayout1Mapper {
  static FuseNavHorizontalLayout1ViewModel fromDto(
    FuseNavHorizontalLayout1Dto dto,
  ) {
    return FuseNavHorizontalLayout1ViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseNavHorizontalLayout1',
      metadata: dto.raw,
    );
  }
}
