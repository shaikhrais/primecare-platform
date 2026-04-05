import '../dtos/stitch_analytics_00118_dto.dart';
import '../../domain/models/stitch_analytics_00118_view_model.dart';

class StitchAnalytics00118Mapper {
  static StitchAnalytics00118ViewModel fromApi(StitchAnalytics00118Dto dto) {
    return StitchAnalytics00118ViewModel(
      title: dto.title,
      status: dto.status,
      reportsAvailable: [],
      aiForecast: '',
    );
  }
}
