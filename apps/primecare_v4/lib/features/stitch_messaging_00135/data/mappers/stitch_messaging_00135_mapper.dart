import '../dtos/stitch_messaging_00135_dto.dart';
import '../../domain/models/stitch_messaging_00135_view_model.dart';

class StitchMessaging00135Mapper {
  static StitchMessaging00135ViewModel fromApi(StitchMessaging00135Dto dto) {
    return StitchMessaging00135ViewModel(
      title: dto.title,
      status: dto.status,
      unreadCount: 0,
      encryption: '',
      activeThreads: [],
    );
  }
}
