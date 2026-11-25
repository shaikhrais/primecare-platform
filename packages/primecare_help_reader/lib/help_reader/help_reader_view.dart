import 'package:flutter/material.dart';
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart'
    show PrimeCard, PrimeCircularProgressIndicator, PrimeDropdownButtonFormField,
        PrimeText, PrimeTextButton, PrimeTextFormField;
import 'package:primecare_component_factory/component_catalogue/prime_component_catalogue.dart' show CatalogueLabels;
import 'package:primecare_theme/advanced_theme/advanced_theme_model.dart' show AdvancedTheme;
import 'package:primecare_theme/advanced_theme/advanced_theme_region.dart' show AdvancedThemeTokens;
import 'help_reader_controller.dart';

/// Caller-supplied references to existing verified controls, never registrations.
/// The host supplies labels in the selected locale and owns its authentication
/// observer, controller retirement and disposal. This body does not mount a host.
class HelpReaderView {
  final HelpReaderController controller;
  final CatalogueLabels Function(String locale) labelsForLocale;
  final Map<String, String> Function(String locale) localeNames;
  final String start, search, locale, previous, next, back, retry, article, open;
  final String idle, loading, empty, error, retired;

  const HelpReaderView({required this.controller, required this.labelsForLocale,
    required this.localeNames, required this.start, required this.search,
    required this.locale, required this.previous, required this.next,
    required this.back, required this.retry, required this.article, required this.open,
    required this.idle, required this.loading, required this.empty,
    required this.error, required this.retired});

  /// No automatic load, network client, route, resource ID or permission grant.
  Widget build(BuildContext context) => AnimatedBuilder(animation: controller,
    builder: (context, _) {
      final state = controller.state;
      final labels = labelsForLocale(state.locale);
      final materialTheme = Theme.of(context);
      final effective = materialTheme.extension<AdvancedThemeTokens>() ??
        AdvancedThemeTokens(AdvancedTheme.defaults(), 'main');
      final rawSpacing = effective.spacing;
      final spacing = rawSpacing.isFinite && rawSpacing >= 0 ? rawSpacing : 0.0;
      final layout = effective.theme.layout;
      final configuredWidth = layout['maxWidth'];
      final width = configuredWidth is num ? configuredWidth.toDouble() : double.infinity;
      final maxWidth = layout['container'] == 'fullwidth' ||
          !width.isFinite || width <= 0 ? double.infinity : width;
      Widget frame(Widget child) => FocusTraversalGroup(child: SingleChildScrollView(
        child: Align(alignment: AlignmentDirectional.topCenter,
          child: ConstrainedBox(constraints: BoxConstraints(maxWidth: maxWidth),
            child: Padding(padding: EdgeInsets.all(spacing), child: child)))));
      final closed = state.phase == 'retired' || state.phase == 'disposed';
      Widget button(String binding, Future<void> Function()? action,
          {String? text, String suffix = ''}) => labels.identify(binding,
        'prime_button', PrimeTextButton(onPressed: action == null ? null : () async {
          // Recheck at invocation; old callbacks cannot revive a retired reader.
          if (!identical(controller.state, state) || controller.state.phase == 'retired' || controller.state.phase == 'disposed' ||
              controller.state.loading) return;
          await action();
        }, child: PrimeText(text ?? labels.text(binding))), suffix: suffix);
      Widget status(String binding, {bool busy = false}) => labels.identify(
        binding, 'prime_card', Semantics(liveRegion: true, child: PrimeCard(
          child: Padding(padding: EdgeInsets.all(spacing), child: Column(
            mainAxisSize: MainAxisSize.min, children: [PrimeText(labels.text(binding)),
              if (busy) PrimeCircularProgressIndicator(semanticsLabel: labels.text(binding))])))));
      if (closed) return frame(status(retired));
      final options = localeNames(state.locale);
      if (options.length != 3 || !options.keys.toSet().containsAll(['en', 'fr', 'es']) ||
          options.values.any((name) => name.trim().isEmpty)) {
        throw ArgumentError('Existing localized reader locale labels required');
      }
      final busy = state.loading;
      final children = <Widget>[
        labels.identify(locale, 'prime_dropdown_web', PrimeDropdownButtonFormField<String>(
          key: ValueKey('reader-locale-${state.locale}'), initialValue: state.locale,
          decoration: InputDecoration(labelText: labels.text(locale)),
          items: [for (final entry in options.entries)
            DropdownMenuItem(value: entry.key, child: PrimeText(entry.value))],
          onChanged: busy ? null : (value) { if (value != null && identical(controller.state, state)) controller.changeLocale(value); })),
        labels.identify(search, 'prime_text_field', PrimeTextFormField(
          key: ValueKey('reader-search-${state.locale}-${state.query}'),
          initialValue: state.query, enabled: !busy, maxLength: 100,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(labelText: labels.text(search)),
          onFieldSubmitted: busy ? null : (value) { if (identical(controller.state, state)) controller.search(value); })),
        if (state.phase == 'idle') ...[status(idle), button(start, controller.load)],
        if (busy) status(loading, busy: true),
        if (state.phase == 'empty') status(empty),
        if (state.phase == 'error') ...[status(error),
          if (controller.canRetry) button(retry, controller.retry),
          button(back, controller.backToList)],
        if (state.phase == 'list') for (var index = 0; index < state.items.length; index++)
          labels.identify(article, 'prime_card', PrimeCard(child: Padding(
            padding: EdgeInsets.all(spacing), child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, children: [
                button(open, () => controller.openArticle(state.items[index]['id'] as String),
                  text: state.items[index]['title'] as String, suffix: '-article-$index'),
                PrimeText(state.items[index]['category'] as String),
                PrimeText(state.items[index]['summary'] as String),
              ]))), suffix: '-article-$index'),
        if (state.phase == 'detail' && state.article != null) ...[
          button(back, controller.backToList),
          labels.identify(article, 'prime_card', PrimeCard(child: Padding(
            padding: EdgeInsets.all(spacing), child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, children: [
                Semantics(header: true, child: PrimeText(state.article!['title'] as String,
                  style: materialTheme.textTheme.titleLarge)),
                PrimeText(state.article!['category'] as String),
                SelectableText(state.article!['body'] as String,
                  style: materialTheme.textTheme.bodyLarge),
              ])))),
        ],
        if (state.phase == 'list' || state.phase == 'empty')
          Wrap(spacing: spacing, runSpacing: spacing, children: [
            button(previous, state.canPrevious ? controller.previousPage : null),
            button(next, state.canNext ? controller.nextPage : null),
          ]),
      ];
      return frame(Column(crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [for (final child in children) Padding(
          padding: EdgeInsets.only(bottom: spacing), child: child)]));
    });
}
