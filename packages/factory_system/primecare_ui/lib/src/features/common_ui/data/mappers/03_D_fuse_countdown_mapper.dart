// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_fuse_countdown_view_model.dart';
import '../dtos/02_M_fuse_countdown_dto.dart';

class FuseCountdownMapper {
  static FuseCountdownViewModel fromDto(FuseCountdownDto dto) {
    return FuseCountdownViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseCountdown',
      metadata: dto.raw,
    );
  }
}
