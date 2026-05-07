import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/clinical_article.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class ClinicalArticleDetailDialog extends StatelessWidget {
  final ClinicalArticle article;

  const ClinicalArticleDetailDialog({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      child: Scaffold(
        appBar: AppBar(
          title: Text(article.title),
          leading: IconButton(
            icon: const Icon(LucideIcons.x),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            IconButton(
              icon: const Icon(LucideIcons.externalLink),
              onPressed: () {
                // TODO: Use url_launcher to open article.url
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  article.category.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              HtmlWidget(
                article.htmlContent,
                textStyle: const TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}
