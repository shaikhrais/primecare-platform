// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_mock_api_view_model.dart';
import '../dtos/02_M_mock_api_dto.dart';

class MockApiMapper {
  static MockApiViewModel fromDto(MockApiDto dto) {
    return MockApiViewModel(
      title: dto.raw['title']?.toString() ?? 'mockApi',
      metadata: dto.raw,
    );
  }
}

