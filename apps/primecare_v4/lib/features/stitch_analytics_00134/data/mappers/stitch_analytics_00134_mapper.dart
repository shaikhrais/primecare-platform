import '../dtos/stitch_analytics_00134_dto.dart';
import '../../domain/models/stitch_analytics_00134_view_model.dart';

class StitchAnalytics00134Mapper {
  static StitchAnalytics00134ViewModel fromApi(StitchAnalytics00134Dto dto) {
    return StitchAnalytics00134ViewModel(
      title: dto.title,
      status: dto.status,
      reportsAvailable: [],
      aiForecast: '',
    );
  }
}
