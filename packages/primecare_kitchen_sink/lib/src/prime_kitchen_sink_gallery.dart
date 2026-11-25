import 'package:primecare_assets/primecare_assets.dart';
import 'package:flutter/material.dart';
import 'package:primecare_component_factory/primecare_component_factory.dart';
import 'package:primecare_data_controls/primecare_data_controls.dart';
import 'package:primecare_dashboard/primecare_dashboard.dart';
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart';
import 'package:primecare_kitchen_sink_catalog/primecare_kitchen_sink_catalog.dart';

int _nextGallery = 0;

/// Developer examples only. Existing factories retain their original names and semantics.
/// The host supplies ThemeData and any theme-toggle callback; this widget grants no authority.
class PrimeKitchenSinkGallery extends StatefulWidget {
  final String locale;
  final VoidCallback? onToggleTheme;
  const PrimeKitchenSinkGallery({
    super.key,
    this.locale = 'en',
    this.onToggleTheme,
  });
  @override
  State<PrimeKitchenSinkGallery> createState() =>
      _PrimeKitchenSinkGalleryState();
}

class _PrimeKitchenSinkGalleryState extends State<PrimeKitchenSinkGallery> {
  final String instance = 'ks-${++_nextGallery}';
  final search = TextEditingController();
  final fields = <String, TextEditingController>{};
  final values = <String, Object?>{};
  final formKey = GlobalKey<FormState>();
  final future = Future<bool>.value(true);
  final deadline = DateTime.now().millisecondsSinceEpoch + 60000;
  late String locale;
  String category = 'all';
  @override
  void initState() {
    super.initState();
    locale = widget.locale;
    _validateLocale(locale);
    search.addListener(_refresh);
  }

  void _validateLocale(String value) {
    if (!['en', 'fr', 'es'].contains(value))
      throw ArgumentError('Unsupported kitchen sink locale');
  }

  @override
  void didUpdateWidget(covariant PrimeKitchenSinkGallery oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.locale != widget.locale) {
      _validateLocale(widget.locale);
      locale = widget.locale;
    }
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  TextEditingController field(String id) =>
      fields.putIfAbsent(id, TextEditingController.new);
  void change(String id, Object? value) {
    if (mounted) setState(() => values[id] = value);
  }

  @override
  void dispose() {
    search.dispose();
    for (final controller in fields.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Map<String, dynamic> get words =>
      (kitchenSinkCatalog['labels'] as Map)[locale] as Map<String, dynamic>;
  String text(String key) => words[key] as String;
  List<Map<String, dynamic>> get stories =>
      (kitchenSinkCatalog['stories'] as List).cast<Map<String, dynamic>>();
  CatalogueLabels labels(String id, [Map<String, dynamic>? metadata]) =>
      CatalogueLabels.fromMetadata(
        metadata ?? component_catalogueMetadata,
        locale,
      ).forInstance('$instance-$id');

  Widget example(Map<String, dynamic> story, double unit) {
    final id = story['id'] as String, scope = '$instance-$id-$locale';
    final l = labels(id), kit = PrimeComponentKit(l, scope);
    final choices = {'one': l.text('optionOne'), 'two': l.text('optionTwo')};
    Widget message([String? value]) => PrimeText(value ?? l.text('success'));
    if (story['family'] == 'data-controls') {
      final dl = labels(id, data_controlsMetadata);
      if (id == 'table') {
        return PrimeVirtualTable(
          labels: dl,
          scope: scope,
          columns: [
            DataColumnSpec('name', l.text('input'), unit * 12),
            DataColumnSpec('status', l.text('status'), unit * 10),
          ],
          rows: List.generate(
            12,
            (i) => DataRowSpec('row-$i', {
              'name': '${text('demo')} ${i + 1}',
              'status': l.text('success'),
            }),
          ),
          rowHeight: unit * 3,
          height: unit * 15,
          minWidth: unit * 6,
          maxWidth: unit * 30,
          actionWidth: unit * 10,
          pageSize: 6,
        );
      }
      if (id == 'autocomplete') return message(text('webOnly'));
      return PrimeDataKit(dl, scope).field(
        id,
        field(id),
        min: id == 'number' ? 0 : null,
        max: id == 'number' ? 100 : null,
      );
    }
    if (story['family'] == 'dashboard-widgets') {
      if (id == 'metric') return message(text('webOnly'));
      final colors = Theme.of(context).colorScheme;
      return PrimeChart(
        labels: labels(id, dashboard_widgetsMetadata),
        data: ChartData.fromJson({
          'kind': id,
          'title': (story['titles'] as Map)[locale],
          'categories': [
            l.text('optionOne'),
            l.text('optionTwo'),
            l.text('status'),
          ],
          'series': [
            {
              'id': 'demo',
              'label': text('demo'),
              'values': [12, 18, 9],
            },
          ],
        }),
        scope: scope,
        height: unit * 14,
        stroke: unit / 8,
        colours: [colors.primary, colors.secondary, colors.tertiary],
        locale: locale,
      );
    }
    switch (id) {
      case 'button':
        return Wrap(
          children: [
            kit.button(
              'button',
              () async => change(id, (values[id] as int? ?? 0) + 1),
              suffix: '-normal',
            ),
            kit.button('button', null, disabled: true, suffix: '-disabled'),
            kit.button(
              'button',
              () async {},
              pressed: true,
              suffix: '-pressed',
            ),
          ],
        );
      case 'input':
      case 'multiline':
        return kit.field(id, field(id));
      case 'select':
        return kit.select(
          choices,
          values[id] as String?,
          (value) => change(id, value),
        );
      case 'checkbox':
      case 'switch':
        return kit.boolean(
          id,
          values[id] == true,
          (value) => change(id, value),
        );
      case 'radio':
        return kit.radio(
          choices,
          values[id] as String?,
          (value) => change(id, value),
        );
      case 'card':
        return kit.card('card', message());
      case 'badge':
        return kit.badge(l.text('success'));
      case 'menu':
        return kit.menu(
          choices,
          (value) => change(id, value),
          disabled: {'two'},
        );
      case 'tabs':
        return kit.tabs(
          ['tabOne', 'tabTwo'],
          [message(l.text('optionOne')), message(l.text('optionTwo'))],
          unit * 10,
        );
      case 'accordion':
        return kit.accordion(message());
      case 'tooltip':
        return kit.tooltip(l.text('tooltip'));
      case 'dialog':
      case 'drawer':
        return PrimeCatalogueModal(
          labels: l,
          scope: scope,
          control: id,
          child: message(),
          approve: id == 'dialog'
              ? () async => change(id, l.text('success'))
              : null,
        );
      case 'form':
        return kit.form(
          formKey,
          [
            kit.field('input', field('form-input'), required: true),
            kit.field('multiline', field('form-multiline')),
          ],
          () async => change(id, l.text('success')),
          minColumnWidth: unit * 16,
          gap: unit,
        );
      case 'loading':
      case 'splash':
      case 'empty':
        return kit.state(id);
      case 'error':
        return kit.state(id, retry: () => change(id, l.text('success')));
      case 'toast':
        return values[id] == true
            ? message()
            : kit.feedback(l.text('success'), () => change(id, true));
      case 'code':
        return PrimeCodePreview(
          labels: l,
          scope: scope,
          code: 'final kit = PrimeComponentKit(labels, scope);',
        );
      case 'preview':
        return kit.preview(message());
      case 'countdown':
        return PrimeCountdown(labels: l, scope: scope, deadline: deadline);
      case 'async':
        return PrimeAsyncBoundary<bool>(
          labels: l,
          scope: scope,
          future: future,
          builder: (_) => message(),
        );
      default:
        throw StateError('Unknown registered developer example: $id');
    }
  }

  @override
  Widget build(BuildContext context) {
    final unit =
        Theme.of(context).textTheme.bodyLarge?.fontSize ??
        kMinInteractiveDimension / 3;
    final visible = stories
        .where(
          (story) =>
              (category == 'all' || category == story['category']) &&
              '${story['id']} ${(story['titles'] as Map)[locale]} ${story['webSymbol']} ${story['flutterSymbol']}'
                  .toLowerCase()
                  .contains(search.text.toLowerCase()),
        )
        .toList();
    final categories = (words['categories'] as Map).cast<String, String>();
    return PrimeScaffold(
      appBar: PrimeAppBar(title: PrimeText(text('title'))),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(unit),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimeText(text('note')),
              Wrap(
                spacing: unit,
                runSpacing: unit,
                children: [
                  SizedBox(
                    width: unit * 20,
                    child: Semantics(
                      identifier: 'kitchen-sink-search',
                      child: PrimeTextField(
                        key: const ValueKey('kitchen-sink-search'),
                        controller: search,
                        decoration: InputDecoration(labelText: text('search')),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: unit * 14,
                    child: PrimeDropdownButtonFormField<String>(
                      isExpanded: true,
                      initialValue: category,
                      decoration: InputDecoration(labelText: text('all')),
                      items: [
                        DropdownMenuItem(
                          value: 'all',
                          child: PrimeText(text('all')),
                        ),
                        for (final entry in categories.entries)
                          DropdownMenuItem(
                            value: entry.key,
                            child: PrimeText(entry.value),
                          ),
                      ],
                      onChanged: (value) {
                        if (value != null) setState(() => category = value);
                      },
                    ),
                  ),
                  SizedBox(
                    width: unit * 10,
                    child: PrimeDropdownButtonFormField<String>(
                      isExpanded: true,
                      initialValue: locale,
                      decoration: InputDecoration(labelText: text('language')),
                      items: [
                        for (final language in ['en', 'fr', 'es'])
                          DropdownMenuItem(
                            value: language,
                            child: PrimeText(language),
                          ),
                      ],
                      onChanged: (value) {
                        if (value != null) setState(() => locale = value);
                      },
                    ),
                  ),
                  if (widget.onToggleTheme != null)
                    PrimeTextButton(
                      onPressed: widget.onToggleTheme,
                      child: PrimeText(text('theme')),
                    ),
                ],
              ),
              Semantics(
                liveRegion: true,
                child: PrimeText('${visible.length} / ${stories.length}'),
              ),
              for (final story in visible)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: unit / 2),
                  child: PrimeCard(
                    key: ValueKey('${story['id']}-$locale'),
                    child: Padding(
                      padding: EdgeInsets.all(unit),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          PrimeText(
                            (story['titles'] as Map)[locale] as String,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          PrimeText(story['flutterSymbol'] as String),
                          Semantics(
                            identifier: 'kitchen-sink-${story['id']}',
                            child: example(story, unit),
                          ),
                          if (values.containsKey(story['id']))
                            PrimeText('${values[story['id']]}'),
                          ExpansionTile(
                            title: PrimeText(text('source')),
                            children: [
                              SelectableText(story['flutterSource'] as String),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              if (visible.isEmpty) PrimeText(text('none')),
              ExpansionTile(
                key: const Key('ks-assets'),
                title: PrimeText(
                  '${text('assets')} (${originalAssetNames.length})',
                ),
                children: [
                  PrimeText(text('assetNote')),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      for (final name in originalAssetNames)
                        SizedBox(
                          width: 144,
                          child: Column(
                            children: [
                              PrimeOriginalAsset(
                                name,
                                key: Key('ks-asset-$name'),
                                width: 120,
                                height: 96,
                              ),
                              PrimeText(name),
                            ],
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              ExpansionTile(
                title: PrimeText(text('reference')),
                children: [
                  for (final raw
                      in (kitchenSinkCatalog['references'] as List)
                          .cast<Map<String, dynamic>>())
                    PrimeListTile(
                      title: PrimeText(raw['id'] as String),
                      subtitle: PrimeText(
                        '${raw['mapped'] == true ? text('mapped') : text('unmapped')} · ${text('pending')}',
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
