// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_qa_dashboard_adapter_view_model.dart';
import '../dtos/02_M_qa_dashboard_adapter_dto.dart';

class QaDashboardAdapterMapper {
  static QaDashboardAdapterViewModel fromDto(QaDashboardAdapterDto dto) {
    return QaDashboardAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'qaDashboardAdapter',
      metadata: dto.raw,
    );
  }
}

