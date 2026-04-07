import '../dtos/stitch_messaging_00147_dto.dart';
import '../../domain/models/stitch_messaging_00147_view_model.dart';

class StitchMessaging00147Mapper {
  static StitchMessaging00147ViewModel fromApi(StitchMessaging00147Dto dto) {
    return StitchMessaging00147ViewModel(
      title: dto.title,
      status: dto.status,
      unreadCount: 0,
      encryption: '',
      activeThreads: [],
    );
  }
}
