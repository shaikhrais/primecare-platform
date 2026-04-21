// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_fuse_splash_screen_view_model.dart';
import '../dtos/02_M_fuse_splash_screen_dto.dart';

class FuseSplashScreenMapper {
  static FuseSplashScreenViewModel fromDto(FuseSplashScreenDto dto) {
    return FuseSplashScreenViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseSplashScreen',
      metadata: dto.raw,
    );
  }
}

