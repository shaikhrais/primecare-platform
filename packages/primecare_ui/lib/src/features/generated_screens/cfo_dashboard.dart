/* 
PRIME:SCREEN=cfo_dashboard
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

class CfoDashboard extends ConsumerStatefulWidget {
  const CfoDashboard({super.key});

  @override
  ConsumerState<CfoDashboard> createState() => _CfoDashboardState();
}

class _CfoDashboardState extends ConsumerState<CfoDashboard> {
  bool _isLoading = false;
  bool _hasError = false;
  String _searchQuery = '';
  final List<String> _transactions = [
    'Tx #5001: Approve Payroll Run - \$124,500.00 (All allied health)',
    'Tx #5002: HST Tax Remittance Q2 - \$18,450.00 (Pending submit)',
    'Tx #5003: Client invoice reconciliation batch #42 - \$8,900.00',
    'Tx #5004: Corporate rent payment - \$4,200.00 (Corporate office)',
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
              const Text('Connecting to accounting ledger database...'),
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
              const Text('Failed to load ledger entries. Plaid API timeout.'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => setState(() => _hasError = false),
                child: const Text('Retry Plaid Sync'),
              ),
            ],
          ),
        ),
      );
    }

    final filteredTransactions = _transactions
        .where((t) => t.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GovDashboardHero(
            title: 'Cfo Dashboard',
            roleName: 'CFO Workspace',
            description: 'Approve payroll runs, review tax compliance reports, and reconcile Plaid ledger accounts.',
          ),
          const SizedBox(height: 24),

          // Simulation control bar
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () => setState(() => _isLoading = true),
                icon: const Icon(Icons.sync),
                label: const Text('Sync Plaid API'),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: () => setState(() => _hasError = true),
                icon: const Icon(Icons.warning_amber),
                label: const Text('Simulate API Failure'),
              ),
              const SizedBox(width: 12),
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('GST/HST Tax remittance sheet exported.')),
                  );
                },
                child: const Text('Export Tax Report'),
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
                  Text('Search Financial Ledger Transactions', style: flutterTheme.textTheme.titleMedium),
                  const SizedBox(height: 12),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search by transaction details or ID...',
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

          // Action Queue list
          Text('Ledger Transactions Queue', style: flutterTheme.textTheme.titleLarge),
          const SizedBox(height: 12),
          if (filteredTransactions.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: Text('No pending ledger entries found.'),
              ),
            )
          else
            ...filteredTransactions.map((t) => Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: const Icon(Icons.account_balance_wallet, color: Colors.green),
                    title: Text(t),
                    trailing: IconButton(
                      icon: const Icon(Icons.check_circle_outline, color: Colors.green),
                      tooltip: 'Approve Transaction',
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('Confirm Transaction Approval'),
                            content: Text('Are you sure you want to approve: $t?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(ctx);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Approved: $t')),
                                  );
                                },
                                child: const Text('Approve'),
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
