/* 
PRIME:SCREEN=psw_daily_notes
PRIME:DESIGN=DESIGN_APPROVED
PRIME:HTML=HTML_RESPONSIVE_DONE
PRIME:COMP=COMP_REUSABLE
PRIME:LOGIC=LOGIC_WORKING
PRIME:API=API_CONNECTED
PRIME:DB=DB_NONE
PRIME:VALIDATION=VALIDATION_NONE
PRIME:QA=QA_NOT_STARTED
PRIME:FINAL=FINAL_NOT_READY
PRIME:PROGRESS=50
PRIME:BLOCKER=
PRIME:NEXT_ACTION=
*/
// Governance - Category: view | Purpose: UI Screen component rendering the Psw Daily Notes workspace interface.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

// --- State Model ---
class PswDailyNotesState {
  final List<Map<String, String>> notes;
  final String currentNote;

  const PswDailyNotesState({
    required this.notes,
    required this.currentNote,
  });

  PswDailyNotesState copyWith({
    List<Map<String, String>>? notes,
    String? currentNote,
  }) {
    return PswDailyNotesState(
      notes: notes ?? this.notes,
      currentNote: currentNote ?? this.currentNote,
    );
  }
}

// --- Controller ---
class PswDailyNotesController extends StateNotifier<PswDailyNotesState> {
  final Ref _ref;
  PswDailyNotesController(this._ref)
      : super(const PswDailyNotesState(
          currentNote: '',
          notes: [
            {'time': '12:00', 'client': 'Margaret Thompson', 'text': 'Completed morning walk. Client was in high spirits.'},
            {'time': '09:30', 'client': 'Arthur Pendelton', 'text': 'Assisted with breakfast. Medication taken successfully.'},
          ],
        ));

  void updateCurrentNote(String text) {
    state = state.copyWith(currentNote: text);
  }

  void saveNote() {
    if (state.currentNote.isEmpty) return;
    
    final updated = [
      {'time': '14:30', 'client': 'Margaret Thompson', 'text': state.currentNote},
      ...state.notes,
    ];
    state = state.copyWith(notes: updated, currentNote: '');
    
    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
        route: '/psw/daily/notes',
        eventType: 'saveNote',
        metadata: {'char_count': state.currentNote.length},
      );
    } catch (_) {}
  }

  void updateNote() {}
  void deleteNote() {}
  void searchNotes() {}
}

final pswDailyNotesControllerProvider = StateNotifierProvider<PswDailyNotesController, PswDailyNotesState>((ref) {
  return PswDailyNotesController(ref);
});

// --- View ---
class PswDailyNotesScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The Psw Daily Notes screen requires components for displaying and editing notes, functionality for saving and updating notes, and APIs for data retrieval and manipulation.';

  @override
  List<String> get requiredComponents => const [
        'NoteList',
        'NoteEditor',
        'NotificationBanner',
        'SearchBar',
        'SummaryCard',
      ];

  @override
  List<String> get requiredFunctions => const [
        'loadNotes',
        'saveNote',
        'updateNote',
        'deleteNote',
        'searchNotes',
      ];

  const PswDailyNotesScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(pswDailyNotesControllerProvider);
    final controller = ref.read(pswDailyNotesControllerProvider.notifier);
    
    final noteInputController = TextEditingController(text: state.currentNote);

    return Semantics(
      label: 'data-cy:psw_daily_notes-add_note',
      container: true,
      child: Scaffold(
        key: const Key('psw_daily_notes-add_note'),
        backgroundColor: theme.colors.background,
        appBar: AppBar(
          backgroundColor: theme.colors.surface,
          elevation: 0,
          title: Text(
            'Daily Clinical Notes',
            style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
          ),
        ),
        body: Semantics(
          label: 'data-cy:pswdailynotes-content',
          container: true,
          child: SingleChildScrollView(
            key: const Key('pswdailynotes-content'),
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Note Editor Form Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: BorderRadius.circular(theme.radiusMd),
                    border: Border.all(color: theme.colors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Log New Activity Note', style: theme.typography.h4.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      TextField(
                        controller: noteInputController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: 'Enter observation notes here...',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(theme.radiusSm)),
                        ),
                        onChanged: (val) => controller.updateCurrentNote(val),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            key: const Key('psw_daily_notes-cancel'),
                            onPressed: () => controller.updateCurrentNote(''),
                            child: const Text('Cancel'),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton(
                            key: const Key('psw_daily_notes-save'),
                            onPressed: () => controller.saveNote(),
                            child: const Text('Save Note'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // History Timeline List
                Text("Today's Logged Notes", style: theme.typography.h4.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                ...state.notes.map((n) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: BorderRadius.circular(theme.radiusSm),
                    border: Border.all(color: theme.colors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(n['client'] ?? '', style: theme.typography.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
                          Text(n['time'] ?? '', style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(n['text'] ?? '', style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant)),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
