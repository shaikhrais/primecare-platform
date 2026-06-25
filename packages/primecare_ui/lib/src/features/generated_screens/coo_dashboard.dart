/* 
PRIME:SCREEN=coo_dashboard
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

class CooDashboard extends ConsumerStatefulWidget {
  const CooDashboard({super.key});

  @override
  ConsumerState<CooDashboard> createState() => _CooDashboardState();
}

class _CooDashboardState extends ConsumerState<CooDashboard> {
  bool _isLoading = false;
  bool _hasError = false;
  String _searchQuery = '';
  final List<String> _branches = [
    'Branch #1: Toronto Downtown - Occupancy: 88% (Uptime: 100%)',
    'Branch #2: Mississauga Central - Occupancy: 74% (Uptime: 99.8%)',
    'Branch #3: Calgary North - Occupancy: 91% (Uptime: 99.9%)',
    'Branch #4: Vancouver Metro - Occupancy: 85% (Uptime: 100%)',
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
              const Text('Fetching operational branch status...'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => setState(() => _isLoading = false),
                child: const Text('Cancel Request'),
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
              const Text('Failed to load operational branch data from coordinator api.'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => setState(() => _hasError = false),
                child: const Text('Retry connection'),
              ),
            ],
          ),
        ),
      );
    }

    final filteredBranches = _branches
        .where((b) => b.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GovDashboardHero(
            title: 'Coo Dashboard',
            roleName: 'COO Workspace',
            description: 'Monitor branch scheduling efficiency, compare operations KPIs, and resolve scheduling issues.',
          ),
          const SizedBox(height: 24),

          // Simulation control bar
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () => setState(() => _isLoading = true),
                icon: const Icon(Icons.location_on),
                label: const Text('Fetch Branches'),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: () => setState(() => _hasError = true),
                icon: const Icon(Icons.signal_wifi_connected_no_internet_4),
                label: const Text('Simulate Network Timeout'),
              ),
              const SizedBox(width: 12),
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Operational branch report dispatched to regional heads.')),
                  );
                },
                child: const Text('Export Branch Report'),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Search Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Search Branch Offices', style: flutterTheme.textTheme.titleMedium),
                  const SizedBox(height: 12),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search by branch location or name...',
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

          // Operations branch listing
          Text('Operational Branch Overview', style: flutterTheme.textTheme.titleLarge),
          const SizedBox(height: 12),
          if (filteredBranches.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: Text('No matching branches found.'),
              ),
            )
          else
            ...filteredBranches.map((b) => Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: const Icon(Icons.home_work, color: Colors.blue),
                    title: Text(b),
                    trailing: IconButton(
                      icon: const Icon(Icons.chevron_right),
                      tooltip: 'Compare branch details',
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('Branch Operational Review'),
                            content: Text(b),
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
