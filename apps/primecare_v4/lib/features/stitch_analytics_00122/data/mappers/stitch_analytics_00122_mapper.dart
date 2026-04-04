import '../dtos/stitch_analytics_00122_dto.dart';
import '../../domain/models/stitch_analytics_00122_view_model.dart';

class StitchAnalytics00122Mapper {
  static StitchAnalytics00122ViewModel fromApi(StitchAnalytics00122Dto dto) {
    return StitchAnalytics00122ViewModel(
      title: dto.title,
      status: dto.status,
    );
  }
}
