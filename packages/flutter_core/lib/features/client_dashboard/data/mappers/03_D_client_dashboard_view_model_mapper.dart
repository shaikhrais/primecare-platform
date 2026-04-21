// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/03_V_client_dashboard_view_model.dart';
import '../dtos/02_M_client_dashboard_view_model_dto.dart';

class ClientDashboardViewModelMapper {
  static ClientDashboardViewModel fromDto(ClientDashboardViewModelDto dto) {
    return ClientDashboardViewModel(
      title: dto.raw['title']?.toString() ?? 'clientDashboardViewModel',
      metadata: dto.raw,
    );
  }
}

