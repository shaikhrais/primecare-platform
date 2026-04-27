// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/route_view_model.dart';
import '../dtos/route_dto.dart';

class RouteMapper {
  static RouteViewModel fromDto(RouteDto dto) {
    return RouteViewModel(
      title: dto.raw['title']?.toString() ?? 'route',
      metadata: dto.raw,
    );
  }
}
