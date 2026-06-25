/* 
PRIME:SCREEN=customer_support_dashboard
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

class CustomerSupportDashboard extends ConsumerStatefulWidget {
  const CustomerSupportDashboard({super.key});

  @override
  ConsumerState<CustomerSupportDashboard> createState() => _CustomerSupportDashboardState();
}

class _CustomerSupportDashboardState extends ConsumerState<CustomerSupportDashboard> {
  bool _isLoading = false;
  bool _hasError = false;
  String _searchQuery = '';
  final List<String> _tickets = [
    'Ticket #4001: Client scheduling conflict resolution',
    'Ticket #4002: Login credential lock assistance request',
    'Ticket #4003: Patient portal onboarding query',
    'Ticket #4004: Payment gateway invoice dispute review',
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
              const Text('Loading support tickets...'),
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
              const Text('Failed to load support data from endpoint.'),
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

    final filteredTickets = _tickets
        .where((t) => t.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GovDashboardHero(
            title: 'Customer Support Dashboard',
            roleName: 'CUSTOMER Workspace',
            description: 'Acknowledge support tickets, search active items, and monitor support SLA compliance.',
          ),
          const SizedBox(height: 24),

          // Simulation controls
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
                    const SnackBar(content: Text('Support notifications dispatched to coordinators.')),
                  );
                },
                child: const Text('Notify Team'),
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
                  Text('Search Active Tickets', style: flutterTheme.textTheme.titleMedium),
                  const SizedBox(height: 12),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search by issue description...',
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

          // Ingestion form replacement/action list
          Text('Support Tickets Queue', style: flutterTheme.textTheme.titleLarge),
          const SizedBox(height: 12),
          if (filteredTickets.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    const Icon(Icons.check_circle, size: 48, color: Colors.green),
                    const SizedBox(height: 12),
                    const Text('All tickets resolved!'),
                  ],
                ),
              ),
            )
          else
            ...filteredTickets.map((t) => Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: const Icon(Icons.help_center),
                    title: Text(t),
                    trailing: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios, size: 14),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('Ticket Inspection'),
                            content: Text(t),
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
