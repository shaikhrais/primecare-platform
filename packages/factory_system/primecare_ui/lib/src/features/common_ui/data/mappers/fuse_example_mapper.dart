// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/fuse_example_view_model.dart';
import '../dtos/fuse_example_dto.dart';

class FuseExampleMapper {
  static FuseExampleViewModel fromDto(FuseExampleDto dto) {
    return FuseExampleViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseExample',
      metadata: dto.raw,
    );
  }
}
