/* 
PRIME:SCREEN=system_dashboard
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

class SystemDashboard extends ConsumerStatefulWidget {
  const SystemDashboard({super.key});

  @override
  ConsumerState<SystemDashboard> createState() => _SystemDashboardState();
}

class _SystemDashboardState extends ConsumerState<SystemDashboard> {
  bool _isLoading = false;
  bool _hasError = false;
  String _searchQuery = '';
  final List<String> _services = [
    'Database Cluster: HEALTHY (Uptime: 14d 2h)',
    'Auth OAuth2 Server: HEALTHY (Uptime: 28d 4h)',
    'API Gateway Worker: HEALTHY (Uptime: 3d 18h)',
    'Platform SMTP Service: ONLINE (Queue: 0 pending)',
    'Double-Entry Accounting Ledger Engine: ONLINE',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              const Text('Scanning platform health...'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => setState(() => _isLoading = false),
                child: const Text('Cancel Scan'),
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
              const Text('Failed to establish API Gateway health telemetry connection.'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => setState(() => _hasError = false),
                child: const Text('Reconnect'),
              ),
            ],
          ),
        ),
      );
    }

    final filteredServices = _services
        .where((s) => s.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GovDashboardHero(
            title: 'System Dashboard',
            roleName: 'SYSTEM Workspace',
            description: 'Monitor microservice health, restart node instances, and inspect connection latencies.',
          ),
          const SizedBox(height: 24),

          // Simulation control bar
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () => setState(() => _isLoading = true),
                icon: const Icon(Icons.flash_on),
                label: const Text('Scan Health'),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: () => setState(() => _hasError = true),
                icon: const Icon(Icons.signal_wifi_off),
                label: const Text('Simulate Offline'),
              ),
              const SizedBox(width: 12),
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Uptime heartbeats dispatched to Slack Alert Manager.')),
                  );
                },
                child: const Text('Test Alerts'),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Search Field
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Search Platform Services', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 12),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search services by name...',
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

          // Action List
          Text('Platform Service Nodes', style: theme.textTheme.titleLarge),
          const SizedBox(height: 12),
          if (filteredServices.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: Text('No platform nodes match the criteria.'),
              ),
            )
          else
            ...filteredServices.map((s) => Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: const Icon(Icons.dns, color: Colors.blue),
                    title: Text(s),
                    trailing: IconButton(
                      icon: const Icon(Icons.restart_alt, size: 20),
                      tooltip: 'Restart Service Node',
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('Confirm Node Restart'),
                            content: Text('Are you sure you want to restart: $s?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(ctx);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Restarting node: $s')),
                                  );
                                },
                                child: const Text('Restart Node'),
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
