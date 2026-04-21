// Layer: 01_INFRASTRUCTURE
import 'package:primecare_core/config/01_I_data_source_mode.dart';
import '../../domain/models/02_M_developer_samples_view_model.dart';
import '../dtos/02_M_developer_samples_dto.dart';
import '../mappers/03_D_developer_samples_mapper.dart';

class DeveloperSamplesAdapter {
  Future<DeveloperSamplesViewModel> getData() async {
    if (DataSourceConfig.currentMode == DataSourceType.hybrid ||
        DataSourceConfig.currentMode == DataSourceType.mock) {
      return DeveloperSamplesMapper.fromMock({
        'title': 'DeveloperSamples Environment',
        'status': 'ACTIVE',
      });
    }

    try {
      // NOTE: Perform Actual Network Call here once ready
      final dummyJson = <String, dynamic>{
        'title': 'Live DeveloperSamples',
        'status': 'ONLINE',
      };
      final dto = DeveloperSamplesDTO.fromJson(dummyJson);
      return DeveloperSamplesMapper.fromApi(dto);
    } catch (e) {
      if (DataSourceConfig.currentMode == DataSourceType.hybrid) {
        return DeveloperSamplesMapper.fromMock({
          'title': 'DeveloperSamples Fallback',
          'status': 'DEGRADED',
        });
      }
      rethrow;
    }
  }
}
