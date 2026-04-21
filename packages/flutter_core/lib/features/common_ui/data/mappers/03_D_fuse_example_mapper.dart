// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_fuse_example_view_model.dart';
import '../dtos/02_M_fuse_example_dto.dart';

class FuseExampleMapper {
  static FuseExampleViewModel fromDto(FuseExampleDto dto) {
    return FuseExampleViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseExample',
      metadata: dto.raw,
    );
  }
}

