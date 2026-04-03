import 'package:primecare_v4/services/dio_client.dart';

class DomainService {
  final DioClient _dioClient = DioClient();

  // Intake Domain
  Future<Map<String, dynamic>> openCase(Map<String, dynamic> data) async {
    try {
      final response = await _dioClient.dio.post('/intake/cases', data: data);
      return response.data;
    } catch (e) {
      throw Exception('Failed to open case: $e');
    }
  }

  // Care Plans Domain
  Future<Map<String, dynamic>> updateCarePlan(Map<String, dynamic> data) async {
    try {
      final response = await _dioClient.dio.post('/care-plans/update', data: data);
      return response.data;
    } catch (e) {
      throw Exception('Failed to update care plan: $e');
    }
  }

  // Training Domain
  Future<Map<String, dynamic>> completeTrainingCourse(Map<String, dynamic> data) async {
    try {
      final response = await _dioClient.dio.post('/training/complete', data: data);
      return response.data;
    } catch (e) {
      throw Exception('Failed to log training completion: $e');
    }
  }

  // Support Domain
  Future<Map<String, dynamic>> escalateTicket(Map<String, dynamic> data) async {
    try {
      final response = await _dioClient.dio.post('/support/tickets/escalate', data: data);
      return response.data;
    } catch (e) {
      throw Exception('Failed to escalate ticket: $e');
    }
  }

  // Franchise Domain
  Future<Map<String, dynamic>> updateTerritory(Map<String, dynamic> data) async {
    try {
      final response = await _dioClient.dio.post('/franchise/territory/update', data: data);
      return response.data;
    } catch (e) {
      throw Exception('Failed to update territory: $e');
    }
  }

  // Reporting Domain (Fetch)
  Future<Map<String, dynamic>> getReportingSummary() async {
    try {
      final response = await _dioClient.dio.get('/reporting/summary');
      return response.data;
    } catch (e) {
      throw Exception('Failed to fetch reporting analytics: $e');
    }
  }
}
