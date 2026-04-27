// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/developer_samples_view_model.dart';
import '../dtos/developer_samples_dto.dart';

class DeveloperSamplesMapper {
  static DeveloperSamplesViewModel fromApi(DeveloperSamplesDTO dto) {
    return DeveloperSamplesViewModel(
      title: dto.apiTitle,
      status: dto.apiStatus,
    );
  }

  static DeveloperSamplesViewModel fromMock(Map<String, dynamic> mock) {
    return DeveloperSamplesViewModel(
      title: mock['title'] as String? ?? 'Mock Dashboard',
      status: mock['status'] as String? ?? 'MOCK',
    );
  }
}
