import '../dtos/stitch_scheduling_00112_dto.dart';
import '../../domain/models/stitch_scheduling_00112_view_model.dart';

class StitchScheduling00112Mapper {
  static StitchScheduling00112ViewModel fromApi(StitchScheduling00112Dto dto) {
    return StitchScheduling00112ViewModel(
      title: dto.title,
      status: dto.status,
    );
  }
}
