// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/03_V_cfo_dashboard_view_model.dart';
import '../dtos/02_M_cfo_dashboard_view_model_dto.dart';

class CfoDashboardViewModelMapper {
  static CfoDashboardViewModel fromDto(CfoDashboardViewModelDto dto) {
    return CfoDashboardViewModel(
      title: dto.raw['title']?.toString() ?? 'cfoDashboardViewModel',
      metadata: dto.raw,
    );
  }
}

