// Governance - Category: view | Purpose: UI Screen component rendering the Psw Visit Notes Screen workspace interface.
import 'package:primecare_ui/primecare_ui.dart';

// --- Data Models ---
class PswVisitNote {
  final String id;
  final String clientName;
  final String summary;
  final DateTime visitDate;
  final String status; // 'draft', 'submitted'
  final bool hasFlag;

  const PswVisitNote({
    required this.id,
    required this.clientName,
    required this.summary,
    required this.visitDate,
    required this.status,
    this.hasFlag = false,
  });

  factory PswVisitNote.fromJson(Map<String, dynamic> json) {
    return PswVisitNote(
      id: json['id'] as String? ?? '',
      clientName: json['clientName'] as String? ?? 'Unknown Client',
      summary: json['summary'] as String? ?? '',
      visitDate: json['visitDate'] != null
          ? DateTime.parse(json['visitDate'] as String)
          : DateTime.now(),
      status: json['status'] as String? ?? 'draft',
      hasFlag: json['hasFlag'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clientName': clientName,
      'summary': summary,
      'visitDate': visitDate.toIso8601String(),
      'status': status,
      'hasFlag': hasFlag,
    };
  }
}

// --- Providers ---
class PswVisitNotesNotifier extends AsyncNotifier<List<PswVisitNote>> {
  @override
  Future<List<PswVisitNote>> build() async {
    final apiClient = ref.watch(apiClientProvider);

    try {
      final response = await apiClient.get('/v1/psw/visit-notes');
      if (response.isSuccess && response.data != null) {
        final data = response.data as List<dynamic>;
        return data
            .map((json) => PswVisitNote.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception(response.error ?? 'Failed to load visit notes');
      }
    } catch (e) {
      // Fallback for simulation or handle properly
      throw Exception('Failed to load visit notes: $e');
    }
  }

  Future<void> addNote(
    String clientName,
    String summary,
    String status,
    bool hasFlag,
  ) async {
    final currentState = state.value ?? [];
    state = const AsyncValue.loading();

    try {
      final apiClient = ref.read(apiClientProvider);

      final response = await apiClient.post(
        '/v1/psw/visit-notes',
        body: {
          'clientName': clientName,
          'summary': summary,
          'status': status,
          'hasFlag': hasFlag,
        },
      );

      if (!response.isSuccess) {
        final statusCode = response.statusCode;
        if (statusCode == 401) {
          throw Exception('Unauthorized: Please log in again.');
        } else if (statusCode == 403) {
          throw Exception(
            'Forbidden: You do not have permission to perform this action.',
          );
        } else {
          throw Exception(
            response.error ??
                'Failed to create visit note (Status: $statusCode)',
          );
        }
      }

      final newNote = PswVisitNote.fromJson(
        response.data as Map<String, dynamic>,
      );
      state = AsyncValue.data([newNote, ...currentState]);
    } catch (e) {
      // Retain previous state and bubble up error
      state = AsyncValue.data(currentState);
      rethrow;
    }
  }
}

final pswVisitNotesProvider =
    AsyncNotifierProvider<PswVisitNotesNotifier, List<PswVisitNote>>(() {
      return PswVisitNotesNotifier();
    });

// --- UI ---
class PswVisitNotesScreen extends GovernedConsumerWidget {
  const PswVisitNotesScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final notesAsync = ref.watch(pswVisitNotesProvider);
    final theme = context.theme;

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        title: Text(
          'Visit Notes',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        backgroundColor: theme.colors.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(LucideIcons.plusCircle, color: theme.colors.primary),
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                backgroundColor: theme.colors.surface,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (context) => const _CreateVisitNoteSheet(),
              );
            },
          ),
        ],
      ),
      body: notesAsync.when(
        data: (notes) {
          if (notes.isEmpty) {
            return EmptyState(
              icon: LucideIcons.clipboardList,
              title: 'No Visit Notes',
              subtitle: 'You have not created any visit notes yet.',
              actionLabel: 'Create Note',
              onAction: () {
                showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: theme.colors.surface,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  builder: (context) => const _CreateVisitNoteSheet(),
                );
              },
            );
          }

          return RefreshIndicator(
            onRefresh: () => ref.refresh(pswVisitNotesProvider.future),
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: notes.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final note = notes[index];
                return _VisitNoteCard(note: note);
              },
            ),
          );
        },
        loading: () => Center(
          child: CircularProgressIndicator(color: theme.colors.primary),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                LucideIcons.alertTriangle,
                color: theme.colors.error,
                size: 48,
              ),
              const SizedBox(height: 16),
              Text('Error loading notes', style: theme.typography.h3),
              const SizedBox(height: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colors.primary,
                  foregroundColor: theme.colors.onPrimary,
                ),
                onPressed: () => ref.refresh(pswVisitNotesProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VisitNoteCard extends StatelessWidget {
  final PswVisitNote note;

  const _VisitNoteCard({required this.note});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return InkWell(
      onTap: () {
        // Handle note tap
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: note.status == 'draft'
                ? theme.colors.warning.withValues(alpha: 0.5)
                : theme.colors.border,
            width: note.status == 'draft' ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      LucideIcons.userCircle,
                      color: theme.colors.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      note.clientName,
                      style: theme.typography.bodyLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: note.status == 'draft'
                        ? theme.colors.warning.withValues(alpha: 0.1)
                        : theme.colors.success.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    note.status.toUpperCase(),
                    style: theme.typography.labelSmall.copyWith(
                      color: note.status == 'draft'
                          ? theme.colors.warning
                          : theme.colors.success,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (note.summary.isNotEmpty) ...[
              Text(
                note.summary,
                style: theme.typography.bodyMedium.copyWith(
                  color: theme.colors.onSurfaceVariant,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      LucideIcons.calendar,
                      size: 14,
                      color: theme.colors.onSurfaceVariant.withValues(
                        alpha: 0.6,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _formatDate(note.visitDate),
                      style: theme.typography.labelSmall.copyWith(
                        color: theme.colors.onSurfaceVariant.withValues(
                          alpha: 0.8,
                        ),
                      ),
                    ),
                  ],
                ),
                if (note.hasFlag)
                  Row(
                    children: [
                      Icon(
                        LucideIcons.flag,
                        size: 14,
                        color: theme.colors.error,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Needs Review',
                        style: theme.typography.labelSmall.copyWith(
                          color: theme.colors.error,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}

class _CreateVisitNoteSheet extends ConsumerStatefulWidget {
  const _CreateVisitNoteSheet();

  @override
  ConsumerState<_CreateVisitNoteSheet> createState() =>
      _CreateVisitNoteSheetState();
}

class _CreateVisitNoteSheetState extends ConsumerState<_CreateVisitNoteSheet> {
  final _clientNameController = TextEditingController();
  final _summaryController = TextEditingController();
  String _status = 'draft';
  bool _hasFlag = false;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _clientNameController.dispose();
    _summaryController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_clientNameController.text.isEmpty) return;

    setState(() => _isSubmitting = true);
    try {
      await ref
          .read(pswVisitNotesProvider.notifier)
          .addNote(
            _clientNameController.text,
            _summaryController.text,
            _status,
            _hasFlag,
          );
      ref
          .read(auraBehavioralTelemetryProvider)
          .logStructuralEvent(
            route: '/psw/visit-notes',
            eventType: 'psw_visit_note_created',
            metadata: {'status': _status, 'hasFlag': _hasFlag},
          );
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        final theme = context.theme;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            backgroundColor: theme.colors.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Create Visit Note', style: theme.typography.h3),
              IconButton(
                icon: const Icon(LucideIcons.x),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _clientNameController,
            decoration: InputDecoration(
              labelText: 'Client Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            initialValue: _status,
            decoration: InputDecoration(
              labelText: 'Status',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            items: const [
              DropdownMenuItem(value: 'draft', child: Text('Draft')),
              DropdownMenuItem(value: 'submitted', child: Text('Submit Final')),
            ],
            onChanged: (val) {
              if (val != null) setState(() => _status = val);
            },
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _summaryController,
            maxLines: 4,
            decoration: InputDecoration(
              labelText: 'Visit Summary',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            title: const Text('Needs Review Flag'),
            subtitle: const Text('Mark if supervisor review is required'),
            value: _hasFlag,
            onChanged: (val) => setState(() => _hasFlag = val),
            contentPadding: EdgeInsets.zero,
            activeThumbColor: theme.colors.primary,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colors.primary,
              foregroundColor: theme.colors.onPrimary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: _isSubmitting ? null : _submit,
            child: _isSubmitting
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Text('Save Note'),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
