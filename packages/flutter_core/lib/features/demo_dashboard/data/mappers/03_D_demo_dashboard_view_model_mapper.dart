// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_demo_dashboard_view_model.dart';
import '../dtos/02_M_demo_dashboard_view_model_dto.dart';

class DemoDashboardViewModelMapper {
  static DemoDashboardViewModel fromDto(DemoDashboardViewModelDto dto) {
    return DemoDashboardViewModel(
      title: dto.raw['title']?.toString() ?? 'demoDashboardViewModel',
      metadata: dto.raw,
    );
  }
}
