import '../dtos/stitch_scheduling_00128_dto.dart';
import '../../domain/models/stitch_scheduling_00128_view_model.dart';

class StitchScheduling00128Mapper {
  static StitchScheduling00128ViewModel fromApi(StitchScheduling00128Dto dto) {
    return StitchScheduling00128ViewModel(
      title: dto.title,
      status: dto.status,
      views: [],
      conflicts: 0,
      primaryResource: '',
    );
  }
}
