import 'package:flutter/material.dart';

class DashboardHeader {
  final String title;
  final String subtitle;
  DashboardHeader({required this.title, required this.subtitle});
}

class PlatformKpiCard extends StatelessWidget {
  final String title;
  final String value;
  final String? trend;

  const PlatformKpiCard({super.key, required this.title, required this.value, this.trend});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 8),
              Text(value, style: Theme.of(context).textTheme.headlineMedium),
              if (trend != null) ...[
                const SizedBox(height: 8),
                Text(trend!, style: Theme.of(context).textTheme.bodySmall),
              ]
            ]
        ),
      )
    );
  }
}

class ActivityLogItem extends StatelessWidget {
  final String title;
  final String timestamp;

  const ActivityLogItem({super.key, required this.title, required this.timestamp});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(timestamp),
    );
  }
}

class DashboardView extends StatelessWidget {
  final DashboardHeader header;
  final List<Widget> kpiCards;
  final List<Widget> recentActivity;

  const DashboardView({
    super.key,
    required this.header,
    this.kpiCards = const [],
    this.recentActivity = const [],
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(header.title, style: Theme.of(context).textTheme.headlineMedium),
          Text(header.subtitle, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 24),
          if (kpiCards.isNotEmpty) ...[
             Wrap(
               spacing: 16,
               runSpacing: 16,
               children: kpiCards.map((w) => SizedBox(width: 200, child: w)).toList(),
             ),
             const SizedBox(height: 24),
          ],
          if (recentActivity.isNotEmpty) ...[
            Text('Recent Activity', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            ...recentActivity,
          ]
        ],
      ),
    );
  }
}

class PrimeCareBarChart extends StatelessWidget {
  final Map<String, double> data;
  final Color barColor;

  const PrimeCareBarChart({super.key, required this.data, required this.barColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      color: barColor.withAlpha(25),
      child: Center(child: Text('Chart Placeholder: ${data.length} data points')),
    );
  }
}
