import '../dtos/stitch_messaging_00119_dto.dart';
import '../../domain/models/stitch_messaging_00119_view_model.dart';

class StitchMessaging00119Mapper {
  static StitchMessaging00119ViewModel fromApi(StitchMessaging00119Dto dto) {
    return StitchMessaging00119ViewModel(
      title: dto.title,
      status: dto.status,
      unreadCount: 0,
      encryption: '',
      activeThreads: [],
    );
  }
}
