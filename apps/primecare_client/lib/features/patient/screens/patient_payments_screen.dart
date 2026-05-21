import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class PatientPaymentsScreen extends StatefulWidget {
  const PatientPaymentsScreen({super.key});

  @override
  State<PatientPaymentsScreen> createState() => _PatientPaymentsScreenState();
}

class _PatientPaymentsScreenState extends State<PatientPaymentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Billing & Payments'), backgroundColor: const Color(0xFF0284C7), foregroundColor: Colors.white),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    color: Colors.red[50],
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(LucideIcons.alertCircle, color: Colors.red),
                              SizedBox(width: 8),
                              Text('Amount Due', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Text(r'$45.00', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.red)),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                            onPressed: () {},
                            child: const Text('Pay Now'),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(LucideIcons.shieldCheck, color: Colors.green),
                              SizedBox(width: 8),
                              Text('Insurance Coverage', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Text('SunLife Financial - Group Plan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          const Text('Policy: #987654321', style: TextStyle(color: Colors.grey)),
                          const SizedBox(height: 8),
                          TextButton(onPressed: () {}, child: const Text('Update Insurance Information')),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text('Transaction History', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _TransactionRow(date: 'Oct 15, 2023', description: 'Physiotherapy Session (Copay)', amount: r'$45.00', status: 'Unpaid'),
                  const Divider(height: 1),
                  _TransactionRow(date: 'Sep 28, 2023', description: 'Massage Therapy', amount: r'$90.00', status: 'Paid'),
                  const Divider(height: 1),
                  _TransactionRow(date: 'Sep 10, 2023', description: 'Physiotherapy Session (Copay)', amount: r'$45.00', status: 'Paid'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _TransactionRow extends StatelessWidget {
  final String date;
  final String description;
  final String amount;
  final String status;
  const _TransactionRow({required this.date, required this.description, required this.amount, required this.status});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.grey[100], shape: BoxShape.circle),
        child: Icon(status == 'Paid' ? LucideIcons.check : LucideIcons.clock, color: status == 'Paid' ? Colors.green : Colors.orange),
      ),
      title: Text(description, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(date),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(amount, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text(status, style: TextStyle(color: status == 'Paid' ? Colors.green : Colors.red, fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
