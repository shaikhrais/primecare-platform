import '../dtos/stitch_scheduling_00140_dto.dart';
import '../../domain/models/stitch_scheduling_00140_view_model.dart';

class StitchScheduling00140Mapper {
  static StitchScheduling00140ViewModel fromApi(StitchScheduling00140Dto dto) {
    return StitchScheduling00140ViewModel(
      title: dto.title,
      status: dto.status,
      views: [],
      conflicts: 0,
      primaryResource: '',
    );
  }
}
