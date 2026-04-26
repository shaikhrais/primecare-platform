// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/config/01_I_data_source_mode.dart';
import '../../domain/models/02_M_common_view_model.dart';
import '../dtos/02_M_common_dto.dart';
import '../mappers/03_D_common_mapper.dart';

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
      // NOTE: Perform Actual Network Call here once ready
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
