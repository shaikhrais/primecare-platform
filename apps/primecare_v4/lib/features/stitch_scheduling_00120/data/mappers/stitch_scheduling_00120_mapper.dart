import '../dtos/stitch_scheduling_00120_dto.dart';
import '../../domain/models/stitch_scheduling_00120_view_model.dart';

class StitchScheduling00120Mapper {
  static StitchScheduling00120ViewModel fromApi(StitchScheduling00120Dto dto) {
    return StitchScheduling00120ViewModel(
      title: dto.title,
      status: dto.status,
      views: [],
      conflicts: 0,
      primaryResource: '',
    );
  }
}
