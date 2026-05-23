// Governance - Category: service | Purpose: --- Domain Entities ---
import 'package:primecare_ui/primecare_ui.dart';

// --- Domain Entities ---
class AuditChecklistItem {
  final String id;
  final String title;
  final bool isChecked;

  const AuditChecklistItem({
    required this.id,
    required this.title,
    required this.isChecked,
  });

  AuditChecklistItem copyWith({bool? isChecked}) {
    return AuditChecklistItem(
      id: id,
      title: title,
      isChecked: isChecked ?? this.isChecked,
    );
  }
}

class AuditRecord {
  final String id;
  final String name;
  final String auditor;
  final DateTime auditDate;
  final String status; // Pending, Completed
  final String grade; // A+, A-, B, C, F

  const AuditRecord({
    required this.id,
    required this.name,
    required this.auditor,
    required this.auditDate,
    required this.status,
    required this.grade,
  });
}

// --- State Model ---
class AuditsState {
  final bool isLoading;
  final List<AuditRecord> auditTimeline;
  final List<AuditChecklistItem> activeChecklist;

  const AuditsState({
    required this.isLoading,
    required this.auditTimeline,
    required this.activeChecklist,
  });

  AuditsState copyWith({
    bool? isLoading,
    List<AuditRecord>? auditTimeline,
    List<AuditChecklistItem>? activeChecklist,
  }) {
    return AuditsState(
      isLoading: isLoading ?? this.isLoading,
      auditTimeline: auditTimeline ?? this.auditTimeline,
      activeChecklist: activeChecklist ?? this.activeChecklist,
    );
  }
}

// --- Controller (Notifier) ---
class AuditsController extends StateNotifier<AuditsState> {
  AuditsController()
      : super(
          AuditsState(
            isLoading: false,
            activeChecklist: const [
              AuditChecklistItem(id: 'chk-1', title: 'Verify database encryption protocols (HIPAA compliance)', isChecked: true),
              AuditChecklistItem(id: 'chk-2', title: 'Audit physical server room entry access logs', isChecked: false),
              AuditChecklistItem(id: 'chk-3', title: 'Review clinical caregiver certification expiries', isChecked: false),
              AuditChecklistItem(id: 'chk-4', title: 'Execute simulated fire drills & safety procedures verification', isChecked: false),
              AuditChecklistItem(id: 'chk-5', title: 'Check patient double-billing exception logging', isChecked: true),
            ],
            auditTimeline: [
              AuditRecord(
                id: 'AUD-991',
                name: 'HIPAA Security Safeguards Audit',
                auditor: 'CISO Office',
                auditDate: DateTime.now().subtract(const Duration(days: 45)),
                status: 'Completed',
                grade: 'A+',
              ),
              AuditRecord(
                id: 'AUD-992',
                name: 'Clinical Quality & Staff Credentials Audit',
                auditor: 'Clinical Director Office',
                auditDate: DateTime.now().subtract(const Duration(days: 15)),
                status: 'Completed',
                grade: 'B',
              ),
              AuditRecord(
                id: 'AUD-993',
                name: 'OSHA Patient Facility Infrastructure Audit',
                auditor: 'External Inspector',
                auditDate: DateTime.now().add(const Duration(days: 10)),
                status: 'Pending',
                grade: '-',
              ),
            ],
          ),
        );

  void toggleChecklistItem(String id) {
    state = state.copyWith(
      activeChecklist: state.activeChecklist.map((item) {
        if (item.id == id) {
          return item.copyWith(isChecked: !item.isChecked);
        }
        return item;
      }).toList(),
    );
  }

  void scheduleAudit(String name, String auditor, DateTime date) {
    final newAudit = AuditRecord(
      id: 'AUD-${DateTime.now().millisecondsSinceEpoch % 1000}',
      name: name,
      auditor: auditor,
      auditDate: date,
      status: 'Pending',
      grade: '-',
    );

    state = state.copyWith(
      auditTimeline: [newAudit, ...state.auditTimeline],
    );
  }

  Future<void> runAuditFinalize() async {
    state = state.copyWith(isLoading: true);
    await Future<void>.delayed(const Duration(milliseconds: 1000));

    final totalItems = state.activeChecklist.length;
    final checkedItems = state.activeChecklist.where((i) => i.isChecked).length;
    final percent = checkedItems / totalItems;

    String calculatedGrade = 'F';
    if (percent >= 0.9) calculatedGrade = 'A+';
    else if (percent >= 0.8) calculatedGrade = 'A-';
    else if (percent >= 0.6) calculatedGrade = 'B';
    else if (percent >= 0.4) calculatedGrade = 'C';

    final finalAudit = AuditRecord(
      id: 'AUD-${DateTime.now().millisecondsSinceEpoch % 1000}',
      name: 'Immediate Incident Remediation Audit',
      auditor: 'Compliance Manager',
      auditDate: DateTime.now(),
      status: 'Completed',
      grade: calculatedGrade,
    );

    state = state.copyWith(
      isLoading: false,
      auditTimeline: [finalAudit, ...state.auditTimeline],
    );
  }
}

// --- Provider ---
final auditsProvider = StateNotifierProvider<AuditsController, AuditsState>((ref) {
  return AuditsController();
});

// --- View ---
class Audits extends GovernedConsumerWidget {
  const Audits({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(auditsProvider);
    final controller = ref.read(auditsProvider.notifier);
    final theme = context.theme;

    final completedCount = state.activeChecklist.where((i) => i.isChecked).length;
    final totalCount = state.activeChecklist.length;
    final progressVal = totalCount == 0 ? 0.0 : completedCount / totalCount;

    // Form inputs
    final nameController = TextEditingController();
    final auditorController = TextEditingController();

    return Scaffold(
      backgroundColor: theme.colors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GovDashboardHero(
              title: 'Clinical & Operational Audits',
              roleName: 'Governance Safety Center',
              description: 'Schedule facility audits, track clinical compliance checklists, review audit performance grades, and finalize clinical remediations.',
              onRefresh: () {},
            ),
            const SizedBox(height: 24),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Checklist & Scheduling Forms
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Checklist card
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Active Quality Checkpoints',
                                  style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                                ),
                                Text(
                                  '$completedCount / $totalCount Solved',
                                  style: theme.typography.bodySmall.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: progressVal,
                                backgroundColor: theme.colors.background,
                                valueColor: AlwaysStoppedAnimation(
                                  progressVal >= 0.8 ? Colors.green : theme.colors.primary,
                                ),
                                minHeight: 8,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.activeChecklist.length,
                              itemBuilder: (context, index) {
                                final item = state.activeChecklist[index];
                                return CheckboxListTile(
                                  title: Text(
                                    item.title,
                                    style: theme.typography.bodyMedium.copyWith(
                                      decoration: item.isChecked ? TextDecoration.lineThrough : null,
                                      color: item.isChecked ? theme.colors.onSurfaceVariant : theme.colors.onSurface,
                                    ),
                                  ),
                                  value: item.isChecked,
                                  activeColor: theme.colors.primary,
                                  onChanged: (val) => controller.toggleChecklistItem(item.id),
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              height: 44,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.colors.primary,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                                onPressed: state.isLoading ? null : () {
                                  controller.runAuditFinalize();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Analyzing checkpoint results... Remediation audit completed successfully!'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                },
                                child: state.isLoading
                                    ? const SizedBox(
                                        height: 18,
                                        width: 18,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor: AlwaysStoppedAnimation(Colors.white),
                                        ),
                                      )
                                    : const Text('Compile Checklist & Finalize Audit'),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Schedule Form Card
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
                            Text(
                              'Schedule Quality Audit Campaign',
                              style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: nameController,
                                    decoration: const InputDecoration(
                                      labelText: 'Audit Scope Name',
                                      border: OutlineInputBorder(),
                                      isDense: true,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: TextField(
                                    controller: auditorController,
                                    decoration: const InputDecoration(
                                      labelText: 'Lead Auditor Scope',
                                      border: OutlineInputBorder(),
                                      isDense: true,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              height: 44,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.colors.background,
                                  side: BorderSide(color: theme.colors.primary),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                                onPressed: () {
                                  if (nameController.text.isNotEmpty && auditorController.text.isNotEmpty) {
                                    controller.scheduleAudit(
                                      nameController.text,
                                      auditorController.text,
                                      DateTime.now().add(const Duration(days: 14)),
                                    );
                                    nameController.clear();
                                    auditorController.clear();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Campaign scheduled. Alert notifications dispatched to auditor.'),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  }
                                },
                                child: Text(
                                  'Schedule Audit',
                                  style: TextStyle(color: theme.colors.primary),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                // Timeline History Panel
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: theme.colors.surface,
                      borderRadius: BorderRadius.circular(theme.radiusMd),
                      border: Border.all(color: theme.colors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Audit Chronology & History',
                          style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                        ),
                        const SizedBox(height: 16),
                        ...state.auditTimeline.map((audit) {
                          final isCompleted = audit.status == 'Completed';
                          Color gradeColor = Colors.grey;
                          if (audit.grade.startsWith('A')) gradeColor = Colors.green;
                          if (audit.grade.startsWith('B')) gradeColor = Colors.orange;

                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: theme.colors.background,
                              borderRadius: BorderRadius.circular(theme.radiusSm),
                              border: Border.all(color: theme.colors.border),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: gradeColor.withOpacity(0.1),
                                  child: Text(
                                    audit.grade,
                                    style: TextStyle(color: gradeColor, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        audit.name,
                                        style: theme.typography.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Auditor: ${audit.auditor} | Date: ${audit.auditDate.toLocal().toString().split(' ')[0]}',
                                        style: theme.typography.labelSmall.copyWith(color: theme.colors.onSurfaceVariant),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
