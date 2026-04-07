import '../dtos/stitch_analytics_00142_dto.dart';
import '../../domain/models/stitch_analytics_00142_view_model.dart';

class StitchAnalytics00142Mapper {
  static StitchAnalytics00142ViewModel fromApi(StitchAnalytics00142Dto dto) {
    return StitchAnalytics00142ViewModel(
      title: dto.title,
      status: dto.status,
      reportsAvailable: [],
      aiForecast: '',
    );
  }
}
