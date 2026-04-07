import '../dtos/stitch_scheduling_00116_dto.dart';
import '../../domain/models/stitch_scheduling_00116_view_model.dart';

class StitchScheduling00116Mapper {
  static StitchScheduling00116ViewModel fromApi(StitchScheduling00116Dto dto) {
    return StitchScheduling00116ViewModel(
      title: dto.title,
      status: dto.status,
      views: [],
      conflicts: 0,
      primaryResource: '',
    );
  }
}
