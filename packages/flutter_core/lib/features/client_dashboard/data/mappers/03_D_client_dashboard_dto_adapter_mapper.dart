// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_client_dashboard_dto_adapter_view_model.dart';
import '../dtos/02_M_client_dashboard_dto_adapter_dto.dart';

class ClientDashboardDtoAdapterMapper {
  static ClientDashboardDtoAdapterViewModel fromDto(ClientDashboardDtoAdapterDto dto) {
    return ClientDashboardDtoAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'clientDashboardDtoAdapter',
      metadata: dto.raw,
    );
  }
}

