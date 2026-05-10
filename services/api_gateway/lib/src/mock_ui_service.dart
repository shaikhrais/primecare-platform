import 'dart:convert';
import 'dart:math';
import 'package:shelf/shelf.dart';

/// Dynamically intercepts and generates valid JSON structures for unhandled UI endpoints.
/// Ported from TypeScript to Dart.
Future<Response> handleMockUIEndpoint(Request request) async {
  final path = request.url.path;
  print('[MockUIService] Intercepting endpoint: /$path');

  if (path == 'dashboard/metrics' || path == 'v1/dashboard/metrics') {
    return Response.ok(jsonEncode({
      'kpis': [
        {'title': 'Activity Level', 'value': 'High', 'status': 'Active'},
        {'title': 'Pending Items', 'value': '12', 'status': 'Pending'},
        {'title': 'System Sync', 'value': 'Active', 'status': 'Active'},
        {'title': 'Alerts', 'value': '0', 'status': 'Active'}
      ],
      'recentActivity': [
        {'title': 'Update Triggered', 'subtitle': 'Automated policy sync.', 'timestamp': '1 Hr Ago', 'icon': 'history', 'color': 'teal'},
        {'title': 'Audit Warning', 'subtitle': 'Item requires review.', 'timestamp': '3 Hrs Ago', 'icon': 'warning', 'color': 'orange'}
      ]
    }), headers: {'Content-Type': 'application/json'});
  }

  // Fallback to Stitch feature generator
  final segments = path.split('/');
  final resourceIdentifier = segments.isNotEmpty ? segments.last : 'data';
  final safeIdentifier = resourceIdentifier.replaceAll('-', '_');

  final mockPayload = _generateStitchFeatures(safeIdentifier);

  final responseObj = {
    '_meta': {
      'source': 'api-gateway:mock_ui_service:stitch_dart_engine',
      'timestamp': DateTime.now().millisecondsSinceEpoch
    },
    safeIdentifier: mockPayload,
  };

  return Response.ok(jsonEncode(responseObj), headers: {'Content-Type': 'application/json'});
}

List<Map<String, dynamic>> _generateStitchFeatures(String key) {
  final match = RegExp(r'\d+').firstMatch(key);
  final seed = match != null ? int.parse(match.group(0)!) : 1;
  final countToGenerate = (seed > 0 && seed <= 150) ? 1 : 10;

  final records = <Map<String, dynamic>>[];
  final random = Random();

  int i = seed;
  for (int k = 0; k < countToGenerate; k++) {
    if (i <= 110) {
      if (i % 3 == 0) {
        records.add({
          'id': 'stitch-telemetry-00$i',
          'type': 'TELEMETRY',
          'title': 'Telemetry Dashboard View [Archetype $i]',
          'kpiMetrics': ['Heart Rate', 'Blood Pressure', 'SpO2'],
          'status': 'Online',
          'layoutColumns': 2,
          'chartData': {'x': [1, 2, 3], 'y': [70, 72, 75]}
        });
      } else if (i % 3 == 1) {
        records.add({
          'id': 'stitch-grid-00$i',
          'type': 'GRID',
          'title': 'Clinical Data Grid [Archetype $i]',
          'columns': ['ID', 'Patient Name', 'Status', 'Last Update'],
          'defaultSort': 'Last Update',
          'status': 'Pending Review',
          'amount': random.nextInt(100000)
        });
      } else {
        records.add({
          'id': 'stitch-form-00$i',
          'type': 'FORM',
          'title': 'Interactive Assessment [Archetype $i]',
          'fields': ['Notes', 'Observations', 'Action Items'],
          'submitAction': 'SAVE_AND_CLOSE',
          'status': 'Draft',
          'facilityTarget': 'General Hospital'
        });
      }
    } else {
      // Archetypes 111-150
      if (i % 4 == 0) {
        records.add({
          'id': 'stitch-scheduling-00$i',
          'type': 'CALENDAR',
          'title': 'Resource Scheduling Hub [Archetype $i]',
          'views': ['Day', 'Week', 'Month'],
          'conflicts': 0,
          'primaryResource': 'PSW Fleet',
          'status': 'Optimized'
        });
      } else if (i % 4 == 1) {
        records.add({
          'id': 'stitch-pharmacy-00$i',
          'type': 'DISPENSARY',
          'title': 'Pharmacy Fulfillment Logs [Archetype $i]',
          'inventoryAlerts': <dynamic>[],
          'prescriptionsPending': 10,
          'status': 'Active Dispensing'
        });
      } else if (i % 4 == 2) {
        records.add({
          'id': 'stitch-analytics-00$i',
          'type': 'ANALYTICS',
          'title': 'Director Data Studio [Archetype $i]',
          'reportsAvailable': ['Monthly Outcomes', 'Cost Reduction', 'Staff Utilization'],
          'aiForecast': 'Stable growth',
          'status': 'Live Sync'
        });
      } else {
        records.add({
          'id': 'stitch-messaging-00$i',
          'type': 'COMMUNICATION',
          'title': 'Secure Care Chat [Archetype $i]',
          'unreadCount': 5,
          'encryption': 'E2EE Active',
          'activeThreads': ['Cardiology Team', 'Patient Support'],
          'status': 'Connected'
        });
      }
    }
    i++;
  }
  return records;
}
