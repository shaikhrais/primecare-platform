// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_client_dashboard_dto_view_model.dart';
import '../dtos/02_M_client_dashboard_dto_dto.dart';

class ClientDashboardDtoMapper {
  static ClientDashboardDtoViewModel fromDto(ClientDashboardDtoDto dto) {
    return ClientDashboardDtoViewModel(
      title: dto.raw['title']?.toString() ?? 'clientDashboardDto',
      metadata: dto.raw,
    );
  }
}

