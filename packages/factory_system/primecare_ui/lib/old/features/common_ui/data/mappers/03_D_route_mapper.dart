// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_route_view_model.dart';
import '../dtos/02_M_route_dto.dart';

class RouteMapper {
  static RouteViewModel fromDto(RouteDto dto) {
    return RouteViewModel(
      title: dto.raw['title']?.toString() ?? 'route',
      metadata: dto.raw,
    );
  }
}
