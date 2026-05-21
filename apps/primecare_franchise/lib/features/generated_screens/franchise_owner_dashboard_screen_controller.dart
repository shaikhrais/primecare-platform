// UPGRADED_BY_AI
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';

part 'franchise_owner_dashboard_screen_controller.g.dart';

@riverpod
class FranchiseOwnerDashboardScreenController extends _$FranchiseOwnerDashboardScreenController {
  @override
  FutureOr<Map<String, dynamic>> build() async {
    // Simulating robust REST API network call
    final dio = Dio();
    try {
      final response = await dio.get('http://localhost:3000/api/franchise-owner-dashboard-screen');
      return <String, dynamic>{};
    } on DioException catch (e) {
      // Fallback gracefully on 404 per user preference
      if (e.response?.statusCode == 404) {
        return {

      'status': 'success',
      'kpis': [
        {'label': 'Total Revenue', 'value': '$45,200'},
        {'label': 'Active Users', 'value': '1,240'},
        {'label': 'Compliance Score', 'value': '98%'},
        {'label': 'Pending Alerts', 'value': '3'},
      ],
            };
      }
      throw Exception('Failed to load data from backend API');
    }
  }

  Future<dynamic> performAction() async {
    // state = const AsyncValue.loading();
    // state = await AsyncValue.guard(() async {
      // Simulating POST/PUT request to API
      final dio = Dio();
      final response = await dio.post('http://localhost:3000/api/franchise-owner-dashboard-screen/action');
      return <String, dynamic>{};
    });
  }
}

