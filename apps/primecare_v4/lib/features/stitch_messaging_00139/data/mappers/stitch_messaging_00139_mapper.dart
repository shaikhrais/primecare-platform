import '../dtos/stitch_messaging_00139_dto.dart';
import '../../domain/models/stitch_messaging_00139_view_model.dart';

class StitchMessaging00139Mapper {
  static StitchMessaging00139ViewModel fromApi(StitchMessaging00139Dto dto) {
    return StitchMessaging00139ViewModel(
      title: dto.title,
      status: dto.status,
      unreadCount: 0,
      encryption: '',
      activeThreads: [],
    );
  }
}
