import '../dtos/stitch_analytics_00138_dto.dart';
import '../../domain/models/stitch_analytics_00138_view_model.dart';

class StitchAnalytics00138Mapper {
  static StitchAnalytics00138ViewModel fromApi(StitchAnalytics00138Dto dto) {
    return StitchAnalytics00138ViewModel(
      title: dto.title,
      status: dto.status,
    );
  }
}
