/* 
PRIME:SCREEN=cto_dashboard
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

class CtoDashboard extends ConsumerStatefulWidget {
  const CtoDashboard({super.key});

  @override
  ConsumerState<CtoDashboard> createState() => _CtoDashboardState();
}

class _CtoDashboardState extends ConsumerState<CtoDashboard> {
  bool _isLoading = false;
  bool _hasError = false;
  String _searchQuery = '';
  final List<String> _releases = [
    'Release v2.8.1: DEPLOYED to production (All services green)',
    'Release v2.8.2-rc2: IN PIPELINE (Aura Integration tests running)',
    'Release v2.7.9: ARCHIVED (Success - Rolled out on June 18)',
    'Release v2.8.0-hotfix1: DEPLOYED to production (Patch for SSO)',
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
              const Text('Fetching telemetry from deployment nodes...'),
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
              const Text('Failed to load release pipeline telemetry.'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => setState(() => _hasError = false),
                child: const Text('Reconnect API'),
              ),
            ],
          ),
        ),
      );
    }

    final filteredReleases = _releases
        .where((r) => r.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GovDashboardHero(
            title: 'Cto Dashboard',
            roleName: 'CTO Workspace',
            description: 'Monitor release management telemetry, inspect API performance logs, and manage rollout configurations.',
          ),
          const SizedBox(height: 24),

          // Simulation control bar
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () => setState(() => _isLoading = true),
                icon: const Icon(Icons.cloud_sync),
                label: const Text('Refresh Deployments'),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: () => setState(() => _hasError = true),
                icon: const Icon(Icons.warning_amber),
                label: const Text('Simulate Pipeline Offline'),
              ),
              const SizedBox(width: 12),
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Triggered automated security compliance scan.')),
                  );
                },
                child: const Text('Run Security Sweep'),
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
                  Text('Search Active Release Rollouts', style: flutterTheme.textTheme.titleMedium),
                  const SizedBox(height: 12),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search release semantic version or status...',
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

          // Rollouts queue list
          Text('Deployment Pipeline Rollouts', style: flutterTheme.textTheme.titleLarge),
          const SizedBox(height: 12),
          if (filteredReleases.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: Text('No matching releases in the pipeline queue.'),
              ),
            )
          else
            ...filteredReleases.map((r) => Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: const Icon(Icons.rocket_launch, color: Colors.purple),
                    title: Text(r),
                    trailing: IconButton(
                      icon: const Icon(Icons.history_sharp),
                      tooltip: 'Rollback Deployment',
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('Trigger Safe Deployment Rollback'),
                            content: Text('Confirm rollback of: $r?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(ctx);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Initiating rollback protocol for: $r')),
                                  );
                                },
                                child: const Text('Rollback'),
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
