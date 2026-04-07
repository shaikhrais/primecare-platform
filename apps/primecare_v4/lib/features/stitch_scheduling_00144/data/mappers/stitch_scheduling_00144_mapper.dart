import '../dtos/stitch_scheduling_00144_dto.dart';
import '../../domain/models/stitch_scheduling_00144_view_model.dart';

class StitchScheduling00144Mapper {
  static StitchScheduling00144ViewModel fromApi(StitchScheduling00144Dto dto) {
    return StitchScheduling00144ViewModel(
      title: dto.title,
      status: dto.status,
      views: [],
      conflicts: 0,
      primaryResource: '',
    );
  }
}
