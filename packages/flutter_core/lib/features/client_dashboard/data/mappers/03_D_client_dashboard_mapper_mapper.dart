// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_client_dashboard_mapper_view_model.dart';
import '../dtos/02_M_client_dashboard_mapper_dto.dart';

class ClientDashboardMapperMapper {
  static ClientDashboardMapperViewModel fromDto(ClientDashboardMapperDto dto) {
    return ClientDashboardMapperViewModel(
      title: dto.raw['title']?.toString() ?? 'clientDashboardMapper',
      metadata: dto.raw,
    );
  }
}

