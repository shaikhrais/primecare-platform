import '../dtos/stitch_scheduling_00148_dto.dart';
import '../../domain/models/stitch_scheduling_00148_view_model.dart';

class StitchScheduling00148Mapper {
  static StitchScheduling00148ViewModel fromApi(StitchScheduling00148Dto dto) {
    return StitchScheduling00148ViewModel(
      title: dto.title,
      status: dto.status,
      views: [],
      conflicts: 0,
      primaryResource: '',
    );
  }
}
