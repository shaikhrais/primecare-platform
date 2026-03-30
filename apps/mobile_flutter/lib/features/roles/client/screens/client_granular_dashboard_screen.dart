import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../core/api_client.dart';

final clientPortalMetricsProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  return await apiClient.get('/v1/client/portal/metrics');
});

class ClientGranularDashboardScreen extends ConsumerWidget {
  const ClientGranularDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsAsync = ref.watch(clientPortalMetricsProvider);

    return PageTemplate(
      title: 'Client Secure Web Portal',
      subtitle: 'Financials, Medical Records, & Care Plan Authorizations',
      kpiCards: null, // Custom flex grid for Portal layout
      children: [
        metricsAsync.when(
          data: (data) => _buildPortalGrid(context, data),
          loading: () => const Center(child: Padding(padding: EdgeInsets.all(40), child: CircularProgressIndicator())),
          error: (err, stack) => Center(child: Text('Error loading portal: $err', style: const TextStyle(color: Colors.red))),
        ),
      ],
    );
  }

  Widget _buildPortalGrid(BuildContext context, Map<String, dynamic> data) {
    // Web Portal uses same 900px breakpoint for PC expansion
    final isDesktop = MediaQuery.of(context).size.width > 900;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Row: Ledger, Claims
        Flex(
          direction: isDesktop ? Axis.horizontal : Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: isDesktop ? 3 : 0, child: _buildBillingLedger()),
            SizedBox(width: isDesktop ? 16 : 0, height: isDesktop ? 0 : 16),
            Expanded(flex: isDesktop ? 2 : 0, child: _buildInsuranceClaims()),
          ],
        ),
        const SizedBox(height: 16),
        // Bottom Row: Care Plan Progress, Document Vault
        Flex(
          direction: isDesktop ? Axis.horizontal : Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 2, child: _buildCarePlanProgress()),
            SizedBox(width: isDesktop ? 16 : 0, height: isDesktop ? 0 : 16),
            Expanded(flex: 1, child: _buildDocumentVault()),
          ],
        ),
      ],
    );
  }

  Widget _buildBillingLedger() {
    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 const Text('Account Billing Ledger', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                 Chip(label: const Text('Outstanding: \$450.00', style: TextStyle(fontSize: 13, color: Colors.white)), backgroundColor: Colors.redAccent),
              ],
           ),
           const SizedBox(height: 16),
           SizedBox(
             height: 250,
             child: SingleChildScrollView(
               scrollDirection: Axis.horizontal,
               child: DataTable(
                 headingRowColor: MaterialStateProperty.resolveWith((states) => Colors.grey.shade50),
                 columns: const [
                    DataColumn(label: Text('Invoice #')),
                    DataColumn(label: Text('Date')),
                    DataColumn(label: Text('Description')),
                    DataColumn(label: Text('Amount')),
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Action')),
                 ],
                 rows: [
                    _ledgerRow('INV-4029', 'Jun 15, 2024', 'Physiotherapy Consult', '\$150.00', 'Pending', Colors.orange),
                    _ledgerRow('INV-4028', 'Jun 08, 2024', 'Personal Care (8h)', '\$300.00', 'Pending', Colors.orange),
                    _ledgerRow('INV-4011', 'Jun 01, 2024', 'Nursing Visit', '\$120.00', 'Paid', Colors.green),
                    _ledgerRow('INV-4009', 'May 25, 2024', 'Personal Care (12h)', '\$450.00', 'Paid', Colors.green),
                 ],
               ),
             ),
           )
        ],
      ),
    );
  }

  DataRow _ledgerRow(String id, String date, String desc, String amt, String status, Color statusColor) {
     return DataRow(
        cells: [
           DataCell(Text(id, style: const TextStyle(fontWeight: FontWeight.bold))),
           DataCell(Text(date, style: const TextStyle(color: Colors.grey))),
           DataCell(Text(desc)),
           DataCell(Text(amt, style: const TextStyle(fontWeight: FontWeight.bold))),
           DataCell(
              Container(
                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                 decoration: BoxDecoration(color: statusColor.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                 child: Text(status, style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 12)),
              )
           ),
           DataCell(
              status == 'Pending' 
              ? ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, minimumSize: const Size(60, 30)), child: const Text('Pay Now', style: TextStyle(fontSize: 12, color: Colors.white)))
              : IconButton(icon: const Icon(Icons.download, size: 20, color: Colors.grey), onPressed: (){})
           )
        ]
     );
  }

  Widget _buildInsuranceClaims() {
    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               const Text('Insurance Claims', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
               const Icon(Icons.health_and_safety, color: Colors.blueAccent),
            ],
          ),
          const SizedBox(height: 16),
          _claimItem('BlueCross - Physical Therapy', 'Submitted Jun 16', 0.4),
          _claimItem('Manulife - RPN Home Care', 'Approved Jun 12', 1.0),
          _claimItem('SunLife - Mobility Equipment', 'Action Required', 0.1),
        ],
      )
    );
  }

  Widget _claimItem(String provider, String status, double progress) {
     return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    Text(provider, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    Text(status, style: TextStyle(color: progress == 1.0 ? Colors.green : (progress == 0.1 ? Colors.red : Colors.grey), fontSize: 12, fontWeight: FontWeight.bold)),
                 ],
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                 value: progress,
                 backgroundColor: Colors.grey.shade200,
                 color: progress == 1.0 ? Colors.green : (progress == 0.1 ? Colors.red : Colors.blueAccent),
                 borderRadius: BorderRadius.circular(4),
              )
           ],
        ),
     );
  }

  Widget _buildCarePlanProgress() {
    return PrimeCareCard(
      child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
            const Text('Clinical Care Plan Progress (Mobility)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Tracking range of motion goals set by primary RPN.', style: TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 24),
            SizedBox(
               height: 180,
               child: BarChart(
                  BarChartData(
                     gridData: const FlGridData(show: true, drawVerticalLine: false),
                     titlesData: const FlTitlesData(
                        bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 22)),
                        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 28)),
                        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                     ),
                     borderData: FlBorderData(show: false),
                     barGroups: [
                        BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 50, color: Colors.grey.shade300)]),
                        BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 65, color: Colors.grey.shade300)]),
                        BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 70, color: Colors.teal.shade300)]),
                        BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 85, color: Colors.teal)]),
                     ]
                  )
               )
            )
         ],
      )
    );
  }

  Widget _buildDocumentVault() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              const Text('Document Vault', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              _docTile('Care Authorization Form', 'Signed Jun 01', Icons.picture_as_pdf, Colors.redAccent),
              const Divider(),
              _docTile('Intake Assessment Record', 'Uploaded May 20', Icons.description, Colors.blueAccent),
              const Divider(),
              _docTile('Tax Receipt (2023)', 'Generated Jan 15', Icons.receipt_long, Colors.green),
              const Divider(),
              OutlinedButton.icon(
                 onPressed: (){},
                 icon: const Icon(Icons.upload_file),
                 label: const Text('Secure Upload File'),
                 style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 45)),
              )
           ]
        ),
     );
  }

  Widget _docTile(String name, String sub, IconData icon, Color color) {
     return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
           children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(width: 12),
              Expanded(
                 child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                       Text(sub, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                    ],
                 )
              ),
              const Icon(Icons.download, size: 20, color: Colors.grey)
           ],
        ),
     );
  }
}
