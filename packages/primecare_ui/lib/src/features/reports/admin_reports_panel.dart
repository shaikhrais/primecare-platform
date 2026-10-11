import 'dart:math';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_models/primecare_models.dart';
import 'package:printing/printing.dart';
import 'admin_report_service.dart';

/// Shared presentation for governed report surfaces; grants and labels come from API.
class AdminReportsPanel extends ConsumerStatefulWidget {
  final String endpoint;
  const AdminReportsPanel({super.key, required this.endpoint});
  @override
  ConsumerState<AdminReportsPanel> createState() => _AdminReportsPanelState();
}
class _AdminReportsPanelState extends ConsumerState<AdminReportsPanel> {
  AdminReportCatalog? _catalog;
  AdminReportResult? _result;
  String? _selected, _notice;
  String _locale = 'en', _readiness = 'all';
  bool _busy = false, _confirmed = false, _deliveryUnknown = false;
  final _search = TextEditingController(), _to = TextEditingController(),
    _subject = TextEditingController(), _message = TextEditingController();
  AdminReportService get service => AdminReportService(ref.read(apiClientProvider), widget.endpoint);
  String label(String key) => _catalog?.resources[key] ?? 'reports.$key'.tr();
  AdminReportRequest get options => AdminReportRequest(locale: _locale,
    search: definition?.supportsFilters == true ? _search.text : '',
    readiness: definition?.supportsFilters == true ? _readiness : 'all');
  AdminReportDefinition? get definition {
    for (final report in _catalog?.reports ?? <AdminReportDefinition>[]) {
      if (report.id == _selected) return report;
    }
    return null;
  }
  @override
  void initState() { super.initState(); Future.microtask(_load); }
  @override
  void dispose() { _search.dispose(); _to.dispose(); _subject.dispose(); _message.dispose(); super.dispose(); }
  Future<void> action(Future<void> Function() work) async {
    if (_busy || !mounted) return;
    setState(() { _busy = true; _notice = null; });
    try { await work(); }
    catch (_) { if (mounted) setState(() { _notice = label(_deliveryUnknown ? 'unknown' : 'error'); }); }
    finally { if (mounted) setState(() { _busy = false; }); }
  }
  Future<void> _load() => action(() async {
    final catalog = await service.catalog(_locale);
    if (mounted) setState(() {
      _catalog = catalog;
      if (!catalog.reports.any((r) => r.id == _selected)) _selected = catalog.reports.firstOrNull?.id;
      _result = null;
    });
  });
  void changed() { setState(() { _result = null; _notice = null; _confirmed = false; }); }
  Widget field(TextEditingController controller, String key, {int maxLength = 150}) => Semantics(
    label: 'report-$key', child: TextField(controller: controller, enabled: !_busy,
      maxLength: maxLength, decoration: InputDecoration(labelText: label(key)),
      onChanged: (_) => changed()));
  @override
  Widget build(BuildContext context) {
    final spacing = context.theme.spacing;
    final result = _result;
    return Semantics(label: 'shared-reports', container: true, child: Card(child: Padding(
      padding: EdgeInsets.all(spacing.lg), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text(label('title'), style: context.theme.typography.h3),
        if (_busy) Semantics(liveRegion: true, label: label('working'), child: const LinearProgressIndicator()),
        Wrap(spacing: spacing.md, runSpacing: spacing.sm, children: [
          Semantics(label: 'report-language', child: DropdownButton<String>(value: _locale,
            items: ['en','fr','es'].map((l) => DropdownMenuItem(value:l, child:Text(l.toUpperCase()))).toList(),
            onChanged: _busy ? null : (l) { if (l != null) { setState(() { _locale = l; _confirmed = false; }); _load(); } })),
          if (_catalog != null && _catalog!.reports.isNotEmpty) Semantics(label: 'report-report', child: SizedBox(width: 220, child: DropdownButton<String>(isExpanded:true,
            value: _selected, items: _catalog!.reports.map((r) => DropdownMenuItem(value:r.id, child:Text(r.title))).toList(),
            onChanged: _busy ? null : (id) { _selected = id; changed(); }))),
          PrimeButton(label: label('refresh'), onPressed: _busy ? null : _load, dataCy:'report-refresh'),
        ]),
        if (definition?.supportsFilters == true) ...[
          field(_search, 'search', maxLength:100),
          Semantics(label:'report-readiness', child: DropdownButton<String>(value:_readiness,
            items: ['all','created','ready'].map((r) => DropdownMenuItem(value:r,child:Text(label(r)))).toList(),
            onChanged:_busy ? null : (v) { if(v != null) { _readiness = v; changed(); } })),
        ],
        Wrap(spacing: spacing.md, runSpacing: spacing.sm, children: [
          PrimeButton(label:label('generate'), dataCy:'report-generate', onPressed:_busy || _selected == null ? null : () => action(() async {
            final data = await service.run(_selected!,options); if(mounted) setState(() { _result=data; });
          })),
          if (definition?.canExport == true) PrimeButton(label:label('pdf'), dataCy:'report-pdf', onPressed:_busy || result == null ? null : () => action(() async {
            final bytes = await service.pdf(_selected!,options);
            await Printing.sharePdf(bytes:bytes, filename:'${_selected!}.pdf');
          })),
        ]),
        if (result != null) ...[
          Text('${result.title} · ${result.classification}'),
          Text('${label('generated')}: ${result.generatedAt.toLocal()} · ${label('scope')}: ${result.scope}'),
          if (result.rows.isEmpty) Text(label('empty')),
          // Full PDF contains every row; bounded preview keeps mobile layouts usable.
          SingleChildScrollView(scrollDirection:Axis.horizontal, child: DataTable(
            columns:result.columns.map((c) => DataColumn(label:Text(c.label))).toList(),
            rows:result.rows.take(50).map((r) => DataRow(cells:result.columns.map((c) => DataCell(Text('${r[c.key]}'))).toList())).toList())),
        ],
        if (definition?.canEmail == true) ...[
          field(_to,'recipient',maxLength:254), field(_subject,'subject'), field(_message,'message',maxLength:1000),
          Semantics(label:'report-confirm',child:CheckboxListTile(value:_confirmed,title:Text(label('confirm')),
            onChanged:_busy ? null : (v) => setState(() { _confirmed = v ?? false; }))),
          PrimeButton(label:label('email'), dataCy:'report-email', onPressed:_busy || result == null || !_confirmed || _deliveryUnknown ? null : () => action(() async {
            final random=Random.secure();
            final key=List.generate(32,(_) => random.nextInt(16).toRadixString(16)).join();
            // A timeout can follow provider acceptance. Block automatic/new-key resends.
            setState(() { _deliveryUnknown=true; });
            final state = await service.email(_selected!,options,to:_to.text.trim(),subject:_subject.text,
              message:_message.text,confirmed:_confirmed,idempotencyKey:key);
            if(mounted) setState(() { _notice=label(state); _confirmed=false; _deliveryUnknown=state!='accepted'; });
          })),
        ],
        if (_notice != null) Semantics(liveRegion:true,child:Text(_notice!)),
      ]))));
  }
}
