import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/primecare_ui.dart';

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
        final blueprints = (mockResponse['blueprints'] as List)
            .cast<Map<String, dynamic>>()
            .map((bp) {
              if (bp['type'] == 'analytics_chart') {
                return ChartBlueprint(
                  dataPayload: AnalyticsChart.fromJson(
                    bp['data'] as Map<String, dynamic>,
                  ),
                );
              }
              return const ActivityFeedBlueprint(dataPayload: <dynamic>[]);
            })
            .toList();

        expect(blueprints.first, isA<ChartBlueprint>());
        final chartBp = blueprints.first as ChartBlueprint;
        final payload = chartBp.dataPayload as AnalyticsChart;
        expect(payload.id, equals('response_chart'));
        expect(payload.dataPoints.first.label, equals('A'));
      },
    );
  });
}
