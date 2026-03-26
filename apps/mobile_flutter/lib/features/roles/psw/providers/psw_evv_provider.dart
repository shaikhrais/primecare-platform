import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_mobile/core/api_client.dart';

// Lightweight model for active EVV visit context
class ActiveVisitData {
  final String id;
  final String patientName;
  final String status;
  final List<String> tasks;

  ActiveVisitData({
    required this.id,
    required this.patientName,
    required this.status,
    required this.tasks,
  });

  factory ActiveVisitData.fromJson(Map<String, dynamic> json) {
    // Extracting client name from the relations
    final clientMap = json['client'] as Map<String, dynamic>?;
    final fullName = clientMap?['fullName'] as String? ?? 'Unknown Patient';

    // For now we map standard structural tasks until dynamic CarePlan is fully joined
    List<String> derivedTasks = [
      'Administer Morning Meds',
      'Assist with Bathing',
      'Log Dietary Intake',
    ];

    return ActiveVisitData(
      id: json['id'] as String? ?? '',
      patientName: fullName,
      status: json['status'] as String? ?? 'scheduled',
      tasks: derivedTasks,
    );
  }
}

final pswEvvLiveProvider = FutureProvider.autoDispose<ActiveVisitData?>((
  ref,
) async {
  final response = await apiClient.get('/v1/psw/schedule/visits');

  if (response is List && response.isNotEmpty) {
    return ActiveVisitData.fromJson(response.first);
  } else {
    return null;
  }
});
