import '../dtos/stitch_analytics_00150_dto.dart';
import '../../domain/models/stitch_analytics_00150_view_model.dart';

class StitchAnalytics00150Mapper {
  static StitchAnalytics00150ViewModel fromApi(StitchAnalytics00150Dto dto) {
    return StitchAnalytics00150ViewModel(
      title: dto.title,
      status: dto.status,
    );
  }
}
