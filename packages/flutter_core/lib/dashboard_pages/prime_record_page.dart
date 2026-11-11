import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeText;
import 'package:flutter/material.dart';
import 'record_page_model.dart';
/// Optional bounded read-only records. The host owns authenticated refresh and query input.
class PrimeRecordPage extends StatelessWidget {
  final RecordPageProjection projection;
  final Map<String, String> labels;
  const PrimeRecordPage({super.key, required this.projection, required this.labels});
  String text(String key) {
    final value = labels[key];
    if (value == null || value.trim().isEmpty) throw ArgumentError('missing_label:$key');
    return value;
  }
  @override Widget build(BuildContext context) => Card(child: Padding(
    padding: const EdgeInsets.all(16), child: Column(
      mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Semantics(container: true, header: true, child: PrimeText(text(projection.kind), style: Theme.of(context).textTheme.titleLarge)),
        Semantics(container: true, liveRegion: true, child: PrimeText(text(projection.status))),
        if (projection.status != 'denied') ...[
          PrimeText(text(projection.synthetic ? 'demo' : 'live')),
          PrimeText(text('bounded')),
          for (final row in projection.rows) Semantics(container: true, child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8), child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, children: [PrimeText(row.title), PrimeText(row.detail)],
            ),
          )),
        ],
      ],
    ),
  ));
}
