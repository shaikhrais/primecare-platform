/* 
PRIME:SCREEN=shareholder_dashboard
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

class ShareholderDashboard extends ConsumerStatefulWidget {
  const ShareholderDashboard({super.key});

  @override
  ConsumerState<ShareholderDashboard> createState() => _ShareholderDashboardState();
}

class _ShareholderDashboardState extends ConsumerState<ShareholderDashboard> {
  bool _isLoading = false;
  bool _hasError = false;
  String _searchQuery = '';
  final List<String> _proposals = [
    'Proposal #6001: Expansion of clinic facilities into Eastern Region (Vote Open)',
    'Proposal #6002: Appointment of external auditing firm for FY2027 (Vote Open)',
    'Proposal #6003: Approval of Q2 Dividend release - \$1.42 per share (Passed)',
    'Proposal #6004: Allocation of capital for AI-driven clinical software (Vote Open)',
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
              const Text('Fetching shareholder proposal records...'),
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
              const Text('Failed to load corporate shareholder agenda.'),
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

    final filteredProposals = _proposals
        .where((p) => p.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GovDashboardHero(
            title: 'Shareholder Dashboard',
            roleName: 'SHAREHOLDER Workspace',
            description: 'Vote on corporate proposals, monitor equity reports, and review annual business performances.',
          ),
          const SizedBox(height: 24),

          // Simulation control bar
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () => setState(() => _isLoading = true),
                icon: const Icon(Icons.business),
                label: const Text('Fetch Agenda'),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: () => setState(() => _hasError = true),
                icon: const Icon(Icons.signal_wifi_off),
                label: const Text('Simulate API Offline'),
              ),
              const SizedBox(width: 12),
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Annual financial prospectus downloaded to device.')),
                  );
                },
                child: const Text('Download Prospectus'),
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
                  Text('Search Active Proposals', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 12),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search proposal topic or code...',
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

          // Agenda / Proposals queue list
          Text('Corporate Voting Agenda', style: theme.textTheme.titleLarge),
          const SizedBox(height: 12),
          if (filteredProposals.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: Text('No matching corporate proposals found.'),
              ),
            )
          else
            ...filteredProposals.map((p) => Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: const Icon(Icons.how_to_vote, color: Colors.indigo),
                    title: Text(p),
                    trailing: TextButton.icon(
                      icon: const Icon(Icons.check, size: 16),
                      label: const Text('Vote'),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('Cast Shareholder Vote'),
                            content: Text('Do you support this proposal:\n\n$p'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(ctx);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Your vote has been cast and recorded.')),
                                  );
                                },
                                child: const Text('Vote YES'),
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
