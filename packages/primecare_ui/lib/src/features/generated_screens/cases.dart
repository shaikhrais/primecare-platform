// Governance - Category: service | Purpose: Core implementation file for the Cases platform logic.
import 'package:primecare_ui/primecare_ui.dart';

// --- Domain Entity ---
class ComplianceCase {
  final String id;
  final String title;
  final String category;
  final String severity; // High, Medium, Low
  final String status; // Pending, Investigating, Resolved
  final DateTime incidentDate;
  final String description;

  const ComplianceCase({
    required this.id,
    required this.title,
    required this.category,
    required this.severity,
    required this.status,
    required this.incidentDate,
    required this.description,
  });

  ComplianceCase copyWith({
    String? status,
    String? severity,
  }) {
    return ComplianceCase(
      id: id,
      title: title,
      category: category,
      severity: severity ?? this.severity,
      status: status ?? this.status,
      incidentDate: incidentDate,
      description: description,
    );
  }
}

// --- State Model ---
class CasesState {
  final bool isLoading;
  final List<ComplianceCase> cases;
  final String selectedSeverityFilter; // 'All', 'High', 'Medium', 'Low'

  const CasesState({
    required this.isLoading,
    required this.cases,
    required this.selectedSeverityFilter,
  });

  CasesState copyWith({
    bool? isLoading,
    List<ComplianceCase>? cases,
    String? selectedSeverityFilter,
  }) {
    return CasesState(
      isLoading: isLoading ?? this.isLoading,
      cases: cases ?? this.cases,
      selectedSeverityFilter: selectedSeverityFilter ?? this.selectedSeverityFilter,
    );
  }
}

// --- Controller (Notifier) ---
class CasesController extends StateNotifier<CasesState> {
  CasesController()
      : super(
          CasesState(
            isLoading: false,
            selectedSeverityFilter: 'All',
            cases: [
              ComplianceCase(
                id: 'CAS-1042',
                title: 'Stale clinical chart update',
                category: 'Clinical Records',
                severity: 'Medium',
                status: 'Investigating',
                incidentDate: DateTime.now().subtract(const Duration(days: 2)),
                description: 'PSW caregiver notes left open for patient assessment without proper closing signatures.',
              ),
              ComplianceCase(
                id: 'CAS-1043',
                title: 'Billing anomaly on double-entry invoice',
                category: 'Financial Billing',
                severity: 'High',
                status: 'Pending',
                incidentDate: DateTime.now().subtract(const Duration(days: 1)),
                description: 'A duplicate billing run was executed on active client accounts for the April payroll.',
              ),
              ComplianceCase(
                id: 'CAS-1044',
                title: 'HIPAA asset disposal verification',
                category: 'Information Security',
                severity: 'Low',
                status: 'Resolved',
                incidentDate: DateTime.now().subtract(const Duration(days: 10)),
                description: 'Verified destruction credentials of old clinical hardware storage devices.',
              ),
            ],
          ),
        );

  void setFilter(String filter) {
    state = state.copyWith(selectedSeverityFilter: filter);
  }

  void addIncident(String title, String category, String severity, String description) {
    final newCase = ComplianceCase(
      id: 'CAS-${DateTime.now().millisecondsSinceEpoch % 10000}',
      title: title,
      category: category,
      severity: severity,
      status: 'Pending',
      incidentDate: DateTime.now(),
      description: description,
    );

    state = state.copyWith(cases: [newCase, ...state.cases]);
  }

  void updateCaseStatus(String id, String newStatus) {
    state = state.copyWith(
      cases: state.cases.map((c) {
        if (c.id == id) {
          return c.copyWith(status: newStatus);
        }
        return c;
      }).toList(),
    );
  }
}

// --- Provider ---
final casesProvider = StateNotifierProvider<CasesController, CasesState>((ref) {
  return CasesController();
});

// --- View ---
class Cases extends GovernedConsumerWidget {
  const Cases({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(casesProvider);
    final controller = ref.read(casesProvider.notifier);
    final theme = context.theme;

    // Filtered case list
    final displayedCases = state.cases.where((c) {
      if (state.selectedSeverityFilter == 'All') return true;
      return c.severity == state.selectedSeverityFilter;
    }).toList();

    // Text field controllers for new incident
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    String selectedCategory = 'Clinical Records';
    String selectedSeverity = 'Medium';

    return Scaffold(
      backgroundColor: theme.colors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GovDashboardHero(
              title: 'Compliance Cases Directory',
              roleName: 'Incidents & Audit Panel',
              description: 'Review active operational exceptions, track ongoing regulatory investigations, and file new incident logs.',
              onRefresh: () {},
            ),
            const SizedBox(height: 24),

            // Severity Filters Bar
            Row(
              children: ['All', 'High', 'Medium', 'Low'].map((filter) {
                final isSelected = state.selectedSeverityFilter == filter;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    label: Text(filter),
                    selected: isSelected,
                    selectedColor: theme.colors.primary.withOpacity(0.2),
                    backgroundColor: theme.colors.surface,
                    labelStyle: TextStyle(
                      color: isSelected ? theme.colors.primary : theme.colors.onSurfaceVariant,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                    onSelected: (val) {
                      if (val) controller.setFilter(filter);
                    },
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cases Directory
                Expanded(
                  flex: 3,
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
                          'Reported Incidents (${displayedCases.length})',
                          style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                        ),
                        const SizedBox(height: 16),
                        if (displayedCases.isEmpty)
                          Padding(
                            padding: const EdgeInsets.all(40.0),
                            child: Center(
                              child: Text(
                                'No cases match the selected filters.',
                                style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                              ),
                            ),
                          )
                        else
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: displayedCases.length,
                            itemBuilder: (context, index) {
                              final c = displayedCases[index];
                              final isHigh = c.severity == 'High';
                              final isMed = c.severity == 'Medium';
                              final isResolved = c.status == 'Resolved';

                              Color severityColor = Colors.green;
                              if (isHigh) severityColor = Colors.red;
                              if (isMed) severityColor = Colors.orange;

                              return Card(
                                color: theme.colors.background,
                                margin: const EdgeInsets.only(bottom: 12),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(theme.radiusSm),
                                  side: BorderSide(color: theme.colors.border),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                                decoration: BoxDecoration(
                                                  color: theme.colors.surface,
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                                child: Text(
                                                  c.id,
                                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                                decoration: BoxDecoration(
                                                  color: severityColor.withOpacity(0.1),
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                                child: Text(
                                                  c.severity,
                                                  style: TextStyle(
                                                    color: severityColor,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          DropdownButton<String>(
                                            value: c.status,
                                            underline: const SizedBox(),
                                            items: ['Pending', 'Investigating', 'Resolved'].map((status) {
                                              return DropdownMenuItem(
                                                value: status,
                                                child: Text(status, style: const TextStyle(fontSize: 12)),
                                              );
                                            }).toList(),
                                            onChanged: (status) {
                                              if (status != null) {
                                                controller.updateCaseStatus(c.id, status);
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        c.title,
                                        style: theme.typography.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        c.description,
                                        style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const Icon(LucideIcons.tag, size: 12),
                                          const SizedBox(width: 4),
                                          Text(
                                            c.category,
                                            style: theme.typography.labelSmall.copyWith(color: theme.colors.onSurfaceVariant),
                                          ),
                                          const SizedBox(width: 16),
                                          const Icon(LucideIcons.calendar, size: 12),
                                          const SizedBox(width: 4),
                                          Text(
                                            c.incidentDate.toLocal().toString().split(' ')[0],
                                            style: theme.typography.labelSmall.copyWith(color: theme.colors.onSurfaceVariant),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                // Report Form
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
                          'File Incident Log',
                          style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: titleController,
                          decoration: const InputDecoration(
                            labelText: 'Incident Title',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                        ),
                        const SizedBox(height: 12),
                        DropdownButtonFormField<String>(
                          value: selectedCategory,
                          decoration: const InputDecoration(
                            labelText: 'Category',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                          items: ['Clinical Records', 'Financial Billing', 'Information Security'].map((cat) {
                            return DropdownMenuItem(value: cat, child: Text(cat));
                          }).toList(),
                          onChanged: (val) {
                            if (val != null) selectedCategory = val;
                          },
                        ),
                        const SizedBox(height: 12),
                        DropdownButtonFormField<String>(
                          value: selectedSeverity,
                          decoration: const InputDecoration(
                            labelText: 'Severity Level',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                          items: ['High', 'Medium', 'Low'].map((sev) {
                            return DropdownMenuItem(value: sev, child: Text(sev));
                          }).toList(),
                          onChanged: (val) {
                            if (val != null) selectedSeverity = val;
                          },
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: descriptionController,
                          maxLines: 4,
                          decoration: const InputDecoration(
                            labelText: 'Detailed Description',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
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
                            onPressed: () {
                              if (titleController.text.isNotEmpty) {
                                controller.addIncident(
                                  titleController.text,
                                  selectedCategory,
                                  selectedSeverity,
                                  descriptionController.text,
                                );
                                titleController.clear();
                                descriptionController.clear();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Incident submitted to active investigations directory.'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              }
                            },
                            child: const Text('Log Incident'),
                          ),
                        ),
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
