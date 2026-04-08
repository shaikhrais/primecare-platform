import '../core/config/api_config.dart';
import '../core/network/api_client.dart';
import '../core/network/api_error.dart';

class DomainService {
  final ApiClient _apiClient = ApiClient();

  // Intake Domain
  Future<Map<String, dynamic>> openCase(Map<String, dynamic> data) async {
    try {
      final response = await _apiClient.post(
        ApiConfig.endpoints['intakeCases']!,
        body: data,
      );
      return response.data;
    } catch (e) {
      throw Exception(ApiErrorAdapter.mapApiError(e));
    }
  }

  // Care Plans Domain
  Future<Map<String, dynamic>> updateCarePlan(Map<String, dynamic> data) async {
    try {
      final response = await _apiClient.post(
        ApiConfig.endpoints['carePlansUpdate']!,
        body: data,
      );
      return response.data;
    } catch (e) {
      throw Exception(ApiErrorAdapter.mapApiError(e));
    }
  }

  // Training Domain
  Future<Map<String, dynamic>> completeTrainingCourse(
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _apiClient.post(
        ApiConfig.endpoints['trainingComplete']!,
        body: data,
      );
      return response.data;
    } catch (e) {
      throw Exception(ApiErrorAdapter.mapApiError(e));
    }
  }

  // Support Domain
  Future<Map<String, dynamic>> escalateTicket(Map<String, dynamic> data) async {
    try {
      final response = await _apiClient.post(
        ApiConfig.endpoints['supportEscalate']!,
        body: data,
      );
      return response.data;
    } catch (e) {
      throw Exception(ApiErrorAdapter.mapApiError(e));
    }
  }

  // Franchise Domain
  Future<Map<String, dynamic>> updateTerritory(
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _apiClient.post(
        ApiConfig.endpoints['franchiseTerritoryUpdate']!,
        body: data,
      );
      return response.data;
    } catch (e) {
      throw Exception(ApiErrorAdapter.mapApiError(e));
    }
  }

  // Reporting Domain (Fetch)
  Future<Map<String, dynamic>> getReportingSummary() async {
    try {
      final response = await _apiClient.get(
        ApiConfig.endpoints['reportingSummary']!,
      );
      return response.data;
    } catch (e) {
      throw Exception(ApiErrorAdapter.mapApiError(e));
    }
  }
}
