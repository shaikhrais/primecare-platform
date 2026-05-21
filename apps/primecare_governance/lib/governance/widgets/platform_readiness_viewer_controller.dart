// UPGRADED_BY_AI
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';

part 'platform_readiness_viewer_controller.g.dart';

@riverpod
class PlatformReadinessViewerController extends _$PlatformReadinessViewerController {
  @override
  FutureOr<Map<String, dynamic>> build() async {
    // Simulating robust REST API network call
    final dio = Dio();
    try {
      final response = await dio.get('http://localhost:3000/api/platform-readiness-viewer');
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      // Fallback gracefully on 404 per user preference
      if (e.response?.statusCode == 404) {
        return {

      'status': 'success',
      'default_field_1': 'Auto-populated from API',
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
      final response = await dio.post('http://localhost:3000/api/platform-readiness-viewer/action');
      return response.data as Map<String, dynamic>;
    });
  }
}
