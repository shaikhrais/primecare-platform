// Governance - Category: view | Purpose: Core implementation file for the Clinical Term Highlighter platform logic.
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../providers/clinical_education_provider.dart';
import 'clinical_article_detail_dialog.dart';

part 'clinical_term_highlighter.g.dart';

class ClinicalTermHighlighter extends ConsumerWidget {
  final String text;
  final TextStyle? style;
  final TextAlign textAlign;

  const ClinicalTermHighlighter({
    super.key,
    required this.text,
    this.style,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final AsyncValue<List<String>> titlesAsync = ref.watch(
      clinicalArticleTitlesProvider,
    );

    return titlesAsync.when(
      data: (List<String> titles) {
        if (titles.isEmpty)
          return Text(text, style: style, textAlign: textAlign);

        // Sort titles by length descending to match longest terms first
        final sortedTitles = List<String>.from(titles)
          ..sort((a, b) => b.length.compareTo(a.length));

        // Create a regex pattern from titles
        final pattern = sortedTitles.map((t) => RegExp.escape(t)).join('|');
        final regex = RegExp('\\b($pattern)\\b', caseSensitive: false);

        final spans = <InlineSpan>[];
        text.splitMapJoin(
          regex,
          onMatch: (Match match) {
            final term = match.group(0)!;
            spans.add(
              TextSpan(
                text: term,
                style: (style ?? theme.textTheme.bodyLarge)?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.dotted,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => _handleTermTap(context, ref, term),
              ),
            );
            return term;
          },
          onNonMatch: (String nonMatch) {
            spans.add(TextSpan(text: nonMatch, style: style));
            return nonMatch;
          },
        );

        return RichText(
          textAlign: textAlign,
          text: TextSpan(children: spans),
        );
      },
      loading: () => Text(text, style: style, textAlign: textAlign),
      error: (_, __) => Text(text, style: style, textAlign: textAlign),
    );
  }

  Future<void> _handleTermTap(
    BuildContext context,
    WidgetRef ref,
    String term,
  ) async {
    final repository = ref.read(clinicalEducationRepositoryProvider);
    final article = await repository.findArticleByTitle(term);

    if (article != null && context.mounted) {
      showDialog<void>(
        context: context,
        builder: (context) => ClinicalArticleDetailDialog(article: article),
      );
    }
  }
}

@riverpod
Future<List<String>> clinicalArticleTitles(Ref ref) async {
  final repository = ref.watch(clinicalEducationRepositoryProvider);
  return repository.getAllArticleTitles();
}
