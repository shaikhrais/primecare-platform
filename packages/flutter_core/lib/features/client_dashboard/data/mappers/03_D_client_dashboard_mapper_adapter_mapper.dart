// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_client_dashboard_mapper_adapter_view_model.dart';
import '../dtos/02_M_client_dashboard_mapper_adapter_dto.dart';

class ClientDashboardMapperAdapterMapper {
  static ClientDashboardMapperAdapterViewModel fromDto(ClientDashboardMapperAdapterDto dto) {
    return ClientDashboardMapperAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'clientDashboardMapperAdapter',
      metadata: dto.raw,
    );
  }
}

