// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_app_view_model.dart';
import '../dtos/02_M_app_dto.dart';

class AppMapper {
  static AppViewModel fromDto(AppDto dto) {
    return AppViewModel(
      title: dto.raw['title']?.toString() ?? 'app',
      metadata: dto.raw,
    );
  }
}
