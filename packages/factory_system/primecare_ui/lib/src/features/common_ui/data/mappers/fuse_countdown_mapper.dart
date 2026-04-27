// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/fuse_countdown_view_model.dart';
import '../dtos/fuse_countdown_dto.dart';

class FuseCountdownMapper {
  static FuseCountdownViewModel fromDto(FuseCountdownDto dto) {
    return FuseCountdownViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseCountdown',
      metadata: dto.raw,
    );
  }
}
