// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_master_dashboard_page_view_model.dart';
import '../dtos/02_M_master_dashboard_page_dto.dart';

class MasterDashboardPageMapper {
  static MasterDashboardPageViewModel fromDto(MasterDashboardPageDto dto) {
    return MasterDashboardPageViewModel(
      title: dto.raw['title']?.toString() ?? 'masterDashboardPage',
      metadata: dto.raw,
    );
  }
}

