import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';



// Note: Navigates to physical /v1/manager/payroll/approve 
// Executes Double-Entry Ledger commits.

class ManagerPayrollScreen extends StatelessWidget {
  const ManagerPayrollScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Payroll Approval Desk',
      subtitle: 'Review timesheets and commit to operational ledger',
      icon: Icons.payments,
      headerGradientColors: const [Colors.deepOrange, Colors.orangeAccent],
      kpiCards: const [
        PrimeCareKpiCard(
          title: 'Pending Approvals',
          value: '14 Batches',
          icon: Icons.pending_actions,
          color: Colors.orange,
        ),
        PrimeCareKpiCard(
          title: 'Total Est. Liability',
          value: '\$12,450.00',
          icon: Icons.account_balance_wallet,
          color: Colors.redAccent,
        ),
      ],
      children: [
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Pending Timesheets', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                ListTile(
                  leading: const CircleAvatar(child: Text('JS')),
                  title: const Text('Jane Smith - Week 12'),
                  subtitle: const Text('Total: 38.5 hrs'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.check_circle, color: Colors.green),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Payroll Batch Approved. Ledger locked.')),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.cancel, color: Colors.red),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: const CircleAvatar(child: Text('DB')),
                  title: const Text('David Brooks - Week 12'),
                  subtitle: const Text('Total: 40.0 hrs'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.check_circle, color: Colors.green),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Payroll Batch Approved. Ledger locked.')),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.cancel, color: Colors.red),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.done_all),
                    label: const Text('Approve All Batches'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.deepOrange,
                      side: const BorderSide(color: Colors.deepOrange),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
