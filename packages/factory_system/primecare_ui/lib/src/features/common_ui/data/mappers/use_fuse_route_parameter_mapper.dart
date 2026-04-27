// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/use_fuse_route_parameter_view_model.dart';
import '../dtos/use_fuse_route_parameter_dto.dart';

class UseFuseRouteParameterMapper {
  static UseFuseRouteParameterViewModel fromDto(UseFuseRouteParameterDto dto) {
    return UseFuseRouteParameterViewModel(
      title: dto.raw['title']?.toString() ?? 'useFuseRouteParameter',
      metadata: dto.raw,
    );
  }
}
