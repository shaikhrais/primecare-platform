import '../dtos/stitch_analytics_00126_dto.dart';
import '../../domain/models/stitch_analytics_00126_view_model.dart';

class StitchAnalytics00126Mapper {
  static StitchAnalytics00126ViewModel fromApi(StitchAnalytics00126Dto dto) {
    return StitchAnalytics00126ViewModel(
      title: dto.title,
      status: dto.status,
    );
  }
}
