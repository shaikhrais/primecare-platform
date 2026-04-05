import '../dtos/stitch_messaging_00131_dto.dart';
import '../../domain/models/stitch_messaging_00131_view_model.dart';

class StitchMessaging00131Mapper {
  static StitchMessaging00131ViewModel fromApi(StitchMessaging00131Dto dto) {
    return StitchMessaging00131ViewModel(
      title: dto.title,
      status: dto.status,
      unreadCount: 0,
      encryption: '',
      activeThreads: [],
    );
  }
}
