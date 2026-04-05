import '../dtos/stitch_scheduling_00132_dto.dart';
import '../../domain/models/stitch_scheduling_00132_view_model.dart';

class StitchScheduling00132Mapper {
  static StitchScheduling00132ViewModel fromApi(StitchScheduling00132Dto dto) {
    return StitchScheduling00132ViewModel(
      title: dto.title,
      status: dto.status,
      views: [],
      conflicts: 0,
      primaryResource: '',
    );
  }
}
