import '../dtos/stitch_messaging_00115_dto.dart';
import '../../domain/models/stitch_messaging_00115_view_model.dart';

class StitchMessaging00115Mapper {
  static StitchMessaging00115ViewModel fromApi(StitchMessaging00115Dto dto) {
    return StitchMessaging00115ViewModel(
      title: dto.title,
      status: dto.status,
    );
  }
}
