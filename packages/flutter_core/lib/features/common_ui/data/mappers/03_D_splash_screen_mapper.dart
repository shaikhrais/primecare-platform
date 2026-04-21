// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_splash_screen_view_model.dart';
import '../dtos/02_M_splash_screen_dto.dart';

class SplashScreenMapper {
  static SplashScreenViewModel fromDto(SplashScreenDto dto) {
    return SplashScreenViewModel(
      title: dto.raw['title']?.toString() ?? 'splashScreen',
      metadata: dto.raw,
    );
  }
}

