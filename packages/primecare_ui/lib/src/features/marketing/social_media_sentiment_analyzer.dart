// Governance - Category: service | Purpose: Core implementation file for the Social Media Sentiment Analyzer platform logic.
import 'package:primecare_ui/primecare_ui.dart';

final socialSentimentProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/marketing/social/sentiment');
  return (response.data as List).cast<Map<String, dynamic>>();
});

class SocialMediaSentimentAnalyzerScreen extends GovernedConsumerWidget {
  const SocialMediaSentimentAnalyzerScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(socialSentimentProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        title: Text('Social Media Sentiment', style: theme.typography.h3),
        actions: [
          IconButton(key: const Key('social_media_sentiment_analyzer_iconbutton_button_1'), 
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(socialSentimentProvider),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err', style: TextStyle(color: theme.colors.error))),
        data: (sentimentData) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Brand Sentiment Overview', style: theme.typography.h2),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: sentimentData.length,
                  itemBuilder: (context, index) {
                    final platform = sentimentData[index];
                    return Card(
                      color: theme.colors.surface,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(platform['platform'] as String, style: theme.typography.h3),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _SentimentIndicator('Positive', platform['positive'] as int, Colors.green, theme),
                                _SentimentIndicator('Neutral', platform['neutral'] as int, Colors.grey, theme),
                                _SentimentIndicator('Negative', platform['negative'] as int, Colors.red, theme),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _SentimentIndicator(String label, int percentage, Color color, PrimeThemeData theme) {
    return Column(
      children: [
        Icon(Icons.circle, color: color, size: 16),
        const SizedBox(height: 4),
        Text('$percentage%', style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
        Text(label, style: theme.typography.labelSmall),
      ],
    );
  }
}
