/* 
PRIME:SCREEN=surgical_video_archive
PRIME:DESIGN=DESIGN_APPROVED
PRIME:HTML=HTML_RESPONSIVE_DONE
PRIME:COMP=COMP_REUSABLE
PRIME:LOGIC=LOGIC_WORKING
PRIME:API=API_ERROR_HANDLED
PRIME:DB=DB_QUERY_READY
PRIME:VALIDATION=VALIDATION_NONE
PRIME:QA=QA_NOT_STARTED
PRIME:FINAL=FINAL_NOT_READY
PRIME:PROGRESS=60
PRIME:BLOCKER=
PRIME:NEXT_ACTION=
*/
// Governance - Category: service | Purpose: Core implementation file for the Surgical Video Archive platform logic.
import 'package:primecare_ui/primecare_ui.dart';

final surgicalVideosProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/education/surgical/videos');
  return (response.data as List).cast<Map<String, dynamic>>();
});

class SurgicalVideoArchiveScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components for viewing, uploading, and managing surgical videos, along with functionality to handle video data and user interactions.';

  @override
  List<String> get requiredComponents => const [
        'VideoList',
        'VideoPlayer',
        'UploadForm',
        'ErrorLog',
        'UserActivityMetrics',
      ];

  @override
  List<String> get requiredFunctions => const [
        'fetchVideoData',
        'refreshVideoList',
        'uploadVideo',
      ];

  const SurgicalVideoArchiveScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(surgicalVideosProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        title: Text('Surgical Video Archive', style: theme.typography.h3),
        actions: [
          IconButton(key: const Key('surgical_video_archive_iconbutton_button_1'), 
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(surgicalVideosProvider),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.upload_file),
              label: const Text('Upload Case'),
            ),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err', style: TextStyle(color: theme.colors.error))),
        data: (videos) => GridView.builder(
          padding: const EdgeInsets.all(24.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: videos.length,
          itemBuilder: (context, index) {
            final video = videos[index];
            return Card(
              color: theme.colors.surface,
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 3,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(color: Colors.black87),
                        Center(child: Icon(Icons.play_circle_outline, size: 64, color: Colors.white.withOpacity(0.8))),
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            color: Colors.black54,
                            child: Text(video['duration'] as String, style: const TextStyle(color: Colors.white, fontSize: 12)),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(video['title'] as String, style: theme.typography.h4, maxLines: 1, overflow: TextOverflow.ellipsis),
                          const SizedBox(height: 4),
                          Text('Surgeon: ${video['surgeon']}', style: theme.typography.bodyMedium),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Date: ${video['date']}', style: theme.typography.labelSmall),
                              Row(
                                children: [
                                  Icon(Icons.remove_red_eye, size: 14, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  Text('${video['views']}', style: theme.typography.labelSmall),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
