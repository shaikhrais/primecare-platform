import 'package:flutter/material.dart';
import 'dashboard_page_model.dart';

/// Optional read-only view. All labels come from the registered host locale.
class PrimeDashboardPage extends StatelessWidget {
  final DashboardPageProjection projection;
  final Map<String, String> labels;
  const PrimeDashboardPage({super.key, required this.projection, required this.labels});
  String text(String key) {
    final value = labels[key];
    if (value == null || value.trim().isEmpty) throw ArgumentError('missing_label:$key');
    return value;
  }
  @override Widget build(BuildContext context) => Card(child: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
      Semantics(container: true, header: true, child: Text(text(projection.family), style: Theme.of(context).textTheme.titleLarge)),
      Semantics(container: true, liveRegion: true, child: Text(text(projection.status == 'ready' ? (projection.synthetic ? 'demo' : 'live') : projection.status))),
      if (projection.status == 'ready') for (final metric in projection.metrics)
        Semantics(container: true, label: '${text(metric.key)}: ${metric.value}', excludeSemantics: true,
          child: Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: Text('${text(metric.key)}: ${metric.value}'))),
    ]),
  ));
}

/// Presentation only: no login, billing, price, retry, navigation or availability mutation.
class PrimeSupportingPage extends StatelessWidget {
  final String kind;
  final Map<String, String> labels;
  const PrimeSupportingPage({super.key, required this.kind, required this.labels});
  @override Widget build(BuildContext context) {
    final status = supportingPageStatus(kind), title = labels[kind], message = labels[status];
    if (title == null || title.trim().isEmpty || message == null || message.trim().isEmpty) throw ArgumentError('missing_label');
    return Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(
      mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Semantics(container: true, header: true, child: Text(title, style: Theme.of(context).textTheme.titleLarge)),
        Semantics(container: true, liveRegion: true, child: Text(message)),
      ],
    )));
  }
}
