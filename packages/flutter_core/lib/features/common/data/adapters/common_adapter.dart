import 'package:primecare_core/config/data_source_mode.dart';
import '../../domain/models/common_view_model.dart';
import '../dtos/common_dto.dart';
import '../mappers/common_mapper.dart';

class CommonAdapter {
  Future<CommonViewModel> getData() async {
    if (DataSourceConfig.currentMode == DataSourceType.hybrid ||
        DataSourceConfig.currentMode == DataSourceType.mock) {
      return CommonMapper.fromMock({
        'title': 'Common Environment',
        'status': 'ACTIVE',
      });
    }

    try {
      // TODO: Perform Actual Network Call
      final dummyJson = <String, dynamic>{
        'title': 'Live Common',
        'status': 'ONLINE',
      };
      final dto = CommonDTO.fromJson(dummyJson);
      return CommonMapper.fromApi(dto);
    } catch (e) {
      if (DataSourceConfig.currentMode == DataSourceType.hybrid) {
        return CommonMapper.fromMock({
          'title': 'Common Fallback',
          'status': 'DEGRADED',
        });
      }
      rethrow;
    }
  }
}
