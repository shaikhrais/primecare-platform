import '../dtos/stitch_messaging_00127_dto.dart';
import '../../domain/models/stitch_messaging_00127_view_model.dart';

class StitchMessaging00127Mapper {
  static StitchMessaging00127ViewModel fromApi(StitchMessaging00127Dto dto) {
    return StitchMessaging00127ViewModel(
      title: dto.title,
      status: dto.status,
      unreadCount: 0,
      encryption: '',
      activeThreads: [],
    );
  }
}
