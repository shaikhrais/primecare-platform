import '../dtos/stitch_messaging_00123_dto.dart';
import '../../domain/models/stitch_messaging_00123_view_model.dart';

class StitchMessaging00123Mapper {
  static StitchMessaging00123ViewModel fromApi(StitchMessaging00123Dto dto) {
    return StitchMessaging00123ViewModel(
      title: dto.title,
      status: dto.status,
      unreadCount: 0,
      encryption: '',
      activeThreads: [],
    );
  }
}
