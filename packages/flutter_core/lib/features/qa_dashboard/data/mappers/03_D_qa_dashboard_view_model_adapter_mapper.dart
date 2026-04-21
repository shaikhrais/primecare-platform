// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_qa_dashboard_view_model_adapter_view_model.dart';
import '../dtos/02_M_qa_dashboard_view_model_adapter_dto.dart';

class QaDashboardViewModelAdapterMapper {
  static QaDashboardViewModelAdapterViewModel fromDto(QaDashboardViewModelAdapterDto dto) {
    return QaDashboardViewModelAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'qaDashboardViewModelAdapter',
      metadata: dto.raw,
    );
  }
}

