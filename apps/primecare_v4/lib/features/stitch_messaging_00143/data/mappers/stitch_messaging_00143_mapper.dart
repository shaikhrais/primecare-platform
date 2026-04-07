import '../dtos/stitch_messaging_00143_dto.dart';
import '../../domain/models/stitch_messaging_00143_view_model.dart';

class StitchMessaging00143Mapper {
  static StitchMessaging00143ViewModel fromApi(StitchMessaging00143Dto dto) {
    return StitchMessaging00143ViewModel(
      title: dto.title,
      status: dto.status,
      unreadCount: 0,
      encryption: '',
      activeThreads: [],
    );
  }
}
