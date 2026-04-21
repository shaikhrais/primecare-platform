// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_master_dashboard_page_adapter_view_model.dart';
import '../dtos/02_M_master_dashboard_page_adapter_dto.dart';

class MasterDashboardPageAdapterMapper {
  static MasterDashboardPageAdapterViewModel fromDto(MasterDashboardPageAdapterDto dto) {
    return MasterDashboardPageAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'masterDashboardPageAdapter',
      metadata: dto.raw,
    );
  }
}

