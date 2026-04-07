import '../dtos/stitch_analytics_00146_dto.dart';
import '../../domain/models/stitch_analytics_00146_view_model.dart';

class StitchAnalytics00146Mapper {
  static StitchAnalytics00146ViewModel fromApi(StitchAnalytics00146Dto dto) {
    return StitchAnalytics00146ViewModel(
      title: dto.title,
      status: dto.status,
      reportsAvailable: [],
      aiForecast: '',
    );
  }
}
