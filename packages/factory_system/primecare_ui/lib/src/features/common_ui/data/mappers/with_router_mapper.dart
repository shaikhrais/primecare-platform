// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/with_router_view_model.dart';
import '../dtos/with_router_dto.dart';

class WithRouterMapper {
  static WithRouterViewModel fromDto(WithRouterDto dto) {
    return WithRouterViewModel(
      title: dto.raw['title']?.toString() ?? 'withRouter',
      metadata: dto.raw,
    );
  }
}
