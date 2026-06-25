/* 
PRIME:SCREEN=clinical_dashboard
PRIME:DESIGN=DESIGN_APPROVED
PRIME:HTML=HTML_LAYOUT_DONE
PRIME:COMP=COMP_MISSING
PRIME:LOGIC=LOGIC_NONE
PRIME:API=API_NONE
PRIME:DB=DB_NONE
PRIME:VALIDATION=VALIDATION_NONE
PRIME:QA=QA_NOT_STARTED
PRIME:FINAL=FINAL_NOT_READY
PRIME:PROGRESS=30
PRIME:BLOCKER=
PRIME:NEXT_ACTION=
*/
import 'package:primecare_ui/primecare_ui.dart';

class ClinicalDashboard extends ConsumerStatefulWidget {
  const ClinicalDashboard({super.key});

  @override
  ConsumerState<ClinicalDashboard> createState() => _ClinicalDashboardState();
}

class _ClinicalDashboardState extends ConsumerState<ClinicalDashboard> {
  bool _isLoading = false;
  bool _hasError = false;
  String _searchQuery = '';
  final List<String> _clinicalCases = [
    'Case #1024: Home medication review for John Doe',
    'Case #1025: Physical therapy rehab for Sarah Smith',
    'Case #1026: Chiropractic adjustment tracking for Robert Johnson',
    'Case #1027: RN shift handoff compliance checklist',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final flutterTheme = Theme.of(context);

    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              const Text('Loading real-time clinical workflows...'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => setState(() => _isLoading = false),
                child: const Text('Cancel Loading'),
              ),
            ],
          ),
        ),
      );
    }

    if (_hasError) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 64),
              const SizedBox(height: 16),
              const Text('Failed to load clinical datasets. Connection timeout.'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => setState(() => _hasError = false),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    final filteredCases = _clinicalCases
        .where((c) => c.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GovDashboardHero(
            title: 'Clinical Dashboard',
            roleName: 'CLINICAL Workspace',
            description: 'Manage clinical cases, verify nurse scheduling, and log secure operational events.',
          ),
          const SizedBox(height: 24),
          
          // State management buttons (real interactions)
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () => setState(() => _isLoading = true),
                icon: const Icon(Icons.refresh),
                label: const Text('Simulate Load'),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: () => setState(() => _hasError = true),
                icon: const Icon(Icons.warning),
                label: const Text('Simulate Error'),
              ),
              const SizedBox(width: 12),
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Operational log files synced to cloud.')),
                  );
                },
                child: const Text('Sync Log Cloud'),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Search Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Search Active Clinical Cases', style: flutterTheme.textTheme.titleMedium),
                  const SizedBox(height: 12),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Type patient name or ID...',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (val) {
                      setState(() {
                        _searchQuery = val;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // List of filtered cases
          Text('Clinical Queue', style: flutterTheme.textTheme.titleLarge),
          const SizedBox(height: 12),
          if (filteredCases.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    const Icon(Icons.inbox, size: 48, color: Colors.grey),
                    const SizedBox(height: 12),
                    const Text('No clinical cases match your query.'),
                  ],
                ),
              ),
            )
          else
            ...filteredCases.map((caseStr) => Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: const Icon(Icons.assignment),
                    title: Text(caseStr),
                    trailing: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios, size: 14),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('Clinical Case Details'),
                            content: Text(caseStr),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: const Text('Close'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                )),
        ],
      ),
    );
  }
}
