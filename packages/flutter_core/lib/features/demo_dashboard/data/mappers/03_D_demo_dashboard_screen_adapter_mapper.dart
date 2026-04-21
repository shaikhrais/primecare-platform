// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_demo_dashboard_screen_adapter_view_model.dart';
import '../dtos/02_M_demo_dashboard_screen_adapter_dto.dart';

class DemoDashboardScreenAdapterMapper {
  static DemoDashboardScreenAdapterViewModel fromDto(DemoDashboardScreenAdapterDto dto) {
    return DemoDashboardScreenAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'demoDashboardScreenAdapter',
      metadata: dto.raw,
    );
  }
}

