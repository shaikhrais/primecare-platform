import '../../../../core/config/data_source_mode.dart';
import '../../domain/models/feature_view_model.dart';
import '../repositories/feature_repository.dart';
import '../mappers/feature_mapper.dart';

abstract class ScreenAdapter {
  Future<List<FeatureViewModel>> getData(String endpointKey);
}

class FeatureAdapter implements ScreenAdapter {
  final FeatureApiRepository apiRepository;
  final FeatureMockRepository mockRepository;

  FeatureAdapter({required this.apiRepository, required this.mockRepository});

  @override
  Future<List<FeatureViewModel>> getData(String endpointKey) async {
    if (DataSourceConfig.currentMode == DataSourceType.mock) {
      final mocks = await mockRepository.getMockFeatures(endpointKey);
      return mocks.map((m) => FeatureMapper.fromMock(m)).toList();
    }

    try {
      final dtos = await apiRepository.getFeatures(endpointKey);
      return dtos.map((dto) => FeatureMapper.fromDto(dto)).toList();
    } catch (e) {
      if (DataSourceConfig.currentMode == DataSourceType.hybrid) {
        final mocks = await mockRepository.getMockFeatures(endpointKey);
        return mocks.map((m) => FeatureMapper.fromMock(m)).toList();
      }
      rethrow;
    }
  }
}
