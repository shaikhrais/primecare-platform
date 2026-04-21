// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_qa_dashboard_mapper_adapter_view_model.dart';
import '../dtos/02_M_qa_dashboard_mapper_adapter_dto.dart';

class QaDashboardMapperAdapterMapper {
  static QaDashboardMapperAdapterViewModel fromDto(QaDashboardMapperAdapterDto dto) {
    return QaDashboardMapperAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'qaDashboardMapperAdapter',
      metadata: dto.raw,
    );
  }
}

