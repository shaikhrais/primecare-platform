import '../dtos/stitch_analytics_00130_dto.dart';
import '../../domain/models/stitch_analytics_00130_view_model.dart';

class StitchAnalytics00130Mapper {
  static StitchAnalytics00130ViewModel fromApi(StitchAnalytics00130Dto dto) {
    return StitchAnalytics00130ViewModel(
      title: dto.title,
      status: dto.status,
      reportsAvailable: [],
      aiForecast: '',
    );
  }
}
