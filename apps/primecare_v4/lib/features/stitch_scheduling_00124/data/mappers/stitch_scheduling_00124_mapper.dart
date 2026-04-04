import '../dtos/stitch_scheduling_00124_dto.dart';
import '../../domain/models/stitch_scheduling_00124_view_model.dart';

class StitchScheduling00124Mapper {
  static StitchScheduling00124ViewModel fromApi(StitchScheduling00124Dto dto) {
    return StitchScheduling00124ViewModel(
      title: dto.title,
      status: dto.status,
    );
  }
}
