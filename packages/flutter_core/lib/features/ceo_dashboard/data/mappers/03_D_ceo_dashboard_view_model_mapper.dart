// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_ceo_dashboard_view_model.dart';
import '../dtos/02_M_ceo_dashboard_view_model_dto.dart';

class CeoDashboardViewModelMapper {
  static CeoDashboardViewModel fromDto(CeoDashboardViewModelDto dto) {
    return CeoDashboardViewModel(
      title: dto.raw['title']?.toString() ?? 'ceoDashboardViewModel',
      metadata: dto.raw,
    );
  }
}
