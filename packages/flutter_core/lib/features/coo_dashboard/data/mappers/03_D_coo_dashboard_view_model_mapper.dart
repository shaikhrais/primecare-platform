// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_coo_dashboard_view_model.dart';
import '../dtos/02_M_coo_dashboard_view_model_dto.dart';

class CooDashboardViewModelMapper {
  static CooDashboardViewModel fromDto(CooDashboardViewModelDto dto) {
    return CooDashboardViewModel(
      title: dto.raw['title']?.toString() ?? 'cooDashboardViewModel',
      metadata: dto.raw,
    );
  }
}
