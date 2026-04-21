// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_qa_dashboard_dto_adapter_view_model.dart';
import '../dtos/02_M_qa_dashboard_dto_adapter_dto.dart';

class QaDashboardDtoAdapterMapper {
  static QaDashboardDtoAdapterViewModel fromDto(QaDashboardDtoAdapterDto dto) {
    return QaDashboardDtoAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'qaDashboardDtoAdapter',
      metadata: dto.raw,
    );
  }
}

