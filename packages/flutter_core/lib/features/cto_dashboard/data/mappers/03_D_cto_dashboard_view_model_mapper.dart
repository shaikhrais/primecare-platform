// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/03_V_cto_dashboard_view_model.dart';
import '../dtos/02_M_cto_dashboard_view_model_dto.dart';

class CtoDashboardViewModelMapper {
  static CtoDashboardViewModel fromDto(CtoDashboardViewModelDto dto) {
    return CtoDashboardViewModel(
      title: dto.raw['title']?.toString() ?? 'ctoDashboardViewModel',
      metadata: dto.raw,
    );
  }
}

