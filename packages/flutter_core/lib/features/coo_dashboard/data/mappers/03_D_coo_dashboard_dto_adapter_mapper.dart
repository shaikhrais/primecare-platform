// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_coo_dashboard_dto_adapter_view_model.dart';
import '../dtos/02_M_coo_dashboard_dto_adapter_dto.dart';

class CooDashboardDtoAdapterMapper {
  static CooDashboardDtoAdapterViewModel fromDto(CooDashboardDtoAdapterDto dto) {
    return CooDashboardDtoAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'cooDashboardDtoAdapter',
      metadata: dto.raw,
    );
  }
}

