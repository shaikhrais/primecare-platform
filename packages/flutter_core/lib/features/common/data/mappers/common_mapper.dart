import '../../domain/models/common_view_model.dart';
import '../dtos/common_dto.dart';

class CommonMapper {
  static CommonViewModel fromApi(CommonDTO dto) {
    return CommonViewModel(title: dto.apiTitle, status: dto.apiStatus);
  }

  static CommonViewModel fromMock(Map<String, dynamic> mock) {
    return CommonViewModel(
      title: mock['title'] as String? ?? 'Mock Dashboard',
      status: mock['status'] as String? ?? 'MOCK',
    );
  }
}
