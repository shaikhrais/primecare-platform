import '../dtos/stitch_analytics_00114_dto.dart';
import '../../domain/models/stitch_analytics_00114_view_model.dart';

class StitchAnalytics00114Mapper {
  static StitchAnalytics00114ViewModel fromApi(StitchAnalytics00114Dto dto) {
    return StitchAnalytics00114ViewModel(
      title: dto.title,
      status: dto.status,
      reportsAvailable: [],
      aiForecast: '',
    );
  }
}
