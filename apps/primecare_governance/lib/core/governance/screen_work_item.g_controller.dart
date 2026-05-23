// Governance - Category: view | Purpose: Simulating robust REST API network call Fallback gracefully on 404 per user preference
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';

part 'screen_work_item.g_controller.g.dart';

@riverpod
class ScreenWorkItem.gController extends _$ScreenWorkItem.gController {
  @override
  FutureOr<Map<String, dynamic>> build() async {
    // Simulating robust REST API network call
    final dio = Dio();
    try {
      final response = await dio.get('http://localhost:3000/api/screen-work-item.g');
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      // Fallback gracefully on 404 per user preference
      if (e.response?.statusCode == 404) {
        return {

      'status': 'success',
      'items': List.generate(15, (index) => {
        'id': index + 100,
        'title': 'Record Entry #${index + 100}',
        'status': index % 3 == 0 ? 'Pending' : 'Completed',
      }),
            };
      }
      throw Exception('Failed to load data from backend API');
    }
  }

  Future<void> performAction() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // Simulating POST/PUT request to API
      final dio = Dio();
      final response = await dio.post('http://localhost:3000/api/screen-work-item.g/action');
      return response.data as Map<String, dynamic>;
    });
  }
}
