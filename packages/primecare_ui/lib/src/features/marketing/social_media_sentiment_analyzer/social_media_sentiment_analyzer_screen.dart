import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/social_media_sentiment_analyzer_header_section.dart';
import 'sections/social_media_sentiment_analyzer_content_summary_section.dart';
import 'sections/social_media_sentiment_analyzer_primary_content_section.dart';
import 'sections/social_media_sentiment_analyzer_action_bar_section.dart';

class SocialMediaSentimentAnalyzerScreen extends StatelessWidget {
  const SocialMediaSentimentAnalyzerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'social_media_sentiment_analyzer',
      title: 'Social Media Sentiment Analyzer',
      child: Column(
        children: const [
          const SocialMediaSentimentAnalyzerHeaderSection(),
          const SocialMediaSentimentAnalyzerContentSummarySection(),
          const SocialMediaSentimentAnalyzerPrimaryContentSection(),
          const SocialMediaSentimentAnalyzerActionBarSection(),
        ],
      ),
    );
  }
}
