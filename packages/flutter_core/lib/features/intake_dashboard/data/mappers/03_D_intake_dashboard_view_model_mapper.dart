// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_intake_dashboard_view_model.dart';
import '../dtos/02_M_intake_dashboard_view_model_dto.dart';

class IntakeDashboardViewModelMapper {
  static IntakeDashboardViewModel fromDto(IntakeDashboardViewModelDto dto) {
    return IntakeDashboardViewModel(
      title: dto.raw['title']?.toString() ?? 'intakeDashboardViewModel',
      metadata: dto.raw,
    );
  }
}
