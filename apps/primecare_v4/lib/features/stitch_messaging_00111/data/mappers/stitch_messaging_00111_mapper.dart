import '../dtos/stitch_messaging_00111_dto.dart';
import '../../domain/models/stitch_messaging_00111_view_model.dart';

class StitchMessaging00111Mapper {
  static StitchMessaging00111ViewModel fromApi(StitchMessaging00111Dto dto) {
    return StitchMessaging00111ViewModel(
      title: dto.title,
      status: dto.status,
      unreadCount: 0,
      encryption: '',
      activeThreads: [],
    );
  }
}
