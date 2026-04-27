// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/routes_config_view_model.dart';
import '../dtos/routes_config_dto.dart';

class RoutesConfigMapper {
  static RoutesConfigViewModel fromDto(RoutesConfigDto dto) {
    return RoutesConfigViewModel(
      title: dto.raw['title']?.toString() ?? 'routesConfig',
      metadata: dto.raw,
    );
  }
}
