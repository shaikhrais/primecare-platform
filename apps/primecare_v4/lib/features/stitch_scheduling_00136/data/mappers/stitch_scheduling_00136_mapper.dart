import '../dtos/stitch_scheduling_00136_dto.dart';
import '../../domain/models/stitch_scheduling_00136_view_model.dart';

class StitchScheduling00136Mapper {
  static StitchScheduling00136ViewModel fromApi(StitchScheduling00136Dto dto) {
    return StitchScheduling00136ViewModel(
      title: dto.title,
      status: dto.status,
      views: [],
      conflicts: 0,
      primaryResource: '',
    );
  }
}
