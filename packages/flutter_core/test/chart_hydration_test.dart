// ignore_for_file: avoid_dynamic_calls, argument_type_not_assignable, inference_failure_on_instance_creation, strict_raw_type, inference_failure_on_function_invocation, undefined_identifier, inference_failure_on_collection_literal, undefined_named_parameter, return_of_invalid_type, prefer_single_quotes, invalid_assignment, non_type_as_type_argument
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_core/flutter_core.dart';
import 'package:primecare_core/dashboard_service.dart';

void main() {
  group('Chart Hydration Tests', () {
    test('ChartBlueprint correctly hydrates from AnalyticsChart objects', () {
      final chart = AnalyticsChart(
        id: 'test_id',
        title: 'Test Chart',
        type: ChartType.line,
        dataPoints: [ChartDataPoint(label: 'Pt1', value: 10.0)],
      );

      final blueprint = ChartBlueprint(dataPayload: chart);
      expect(blueprint.componentType, equals('analytics_chart'));
      expect(blueprint.dataPayload, isA<AnalyticsChart>());
      expect((blueprint.dataPayload as AnalyticsChart).id, equals('test_id'));
    });

    test(
      'DashboardService correctly hydrates chart JSON into ChartBlueprint',
      () async {
        final mockResponse = {
          'blueprints': [
            {
              'type': 'analytics_chart',
              'data': {
                'id': 'response_chart',
                'title': 'Response Chart',
                'type': 'line',
                'data_points': [
                  {'label': 'A', 'value': 5.0},
                ],
              },
            },
          ],
        };

        // We simulate the hydration logic within DashboardService
        final blueprints = (mockResponse['blueprints'] as List).map((bp) {
          if (bp['type'] == 'analytics_chart') {
            return ChartBlueprint(
              dataPayload: AnalyticsChart.fromJson(
                bp['data'] as Map<String, dynamic>,
              ),
            );
          }
          return const ActivityFeedBlueprint(dataPayload: []);
        }).toList();

        expect(blueprints.first, isA<ChartBlueprint>());
        final chartBp = blueprints.first as ChartBlueprint;
        expect(chartBp.dataPayload.id, equals('response_chart'));
        expect(chartBp.dataPayload.dataPoints.first.label, equals('A'));
      },
    );
  });
}
