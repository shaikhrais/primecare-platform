import '../../domain/models/feature_view_model.dart';
import '../dtos/feature_dto.dart';

class FeatureMapper {
  static FeatureViewModel fromDto(FeatureDto dto) {
    return FeatureViewModel(
      id: dto.id,
      title: dto.title,
      status: dto.status,
      description: dto.description,
      type: dto.type,
      rawPayload: dto.rawJson,
    );
  }

  static FeatureViewModel fromMock(Map<String, dynamic> mock) {
    return FeatureViewModel(
      id: mock['id']?.toString() ?? 'MOCK-UNK',
      title: mock['title']?.toString() ?? 'Mock Record',
      status: mock['status']?.toString() ?? 'Draft',
      description:
          mock['description']?.toString() ?? 'Generative Mock Content.',
      type: mock['type']?.toString() ?? 'UNKNOWN',
      rawPayload: mock,
    );
  }
}
