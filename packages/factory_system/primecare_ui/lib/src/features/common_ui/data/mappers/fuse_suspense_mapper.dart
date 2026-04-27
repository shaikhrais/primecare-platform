// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/fuse_suspense_view_model.dart';
import '../dtos/fuse_suspense_dto.dart';

class FuseSuspenseMapper {
  static FuseSuspenseViewModel fromDto(FuseSuspenseDto dto) {
    return FuseSuspenseViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseSuspense',
      metadata: dto.raw,
    );
  }
}
