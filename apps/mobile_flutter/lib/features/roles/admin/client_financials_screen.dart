import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:math' as math;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:primecare_mobile/core/api_config.dart';
import 'package:primecare_mobile/core/api_client.dart';

final financialsProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final response = await http.get(Uri.parse('${ApiClient.baseUrl}${ApiConfig.endpoints['clientFinancials']}'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['records'] as List<dynamic>;
    } else {
      throw Exception('Failed to load financials');
    }
  } catch (e) {
    debugPrint('API Error: \$e');
    return [];
  }
});

class ClientFinancialsScreen extends ConsumerWidget {
  const ClientFinancialsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final financialsAsync = ref.watch(financialsProvider);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50.withOpacity(0.5),
      appBar: const PrimeCareAppBar(title: 'Franchise Financials & Billing'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Revenue Projections VS Expenses', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                     decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(8)), 
                     child: const Text('Export Ledger', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))
                  )
               ]
            ),
            const SizedBox(height: 32),
            PrimeCareCard(
               child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                     Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           const Text('Q1-Q3 Pipeline', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                           Row(
                              children: [
                                 Row(children: [Container(width: 12, height: 2, color: Colors.teal.shade600), const SizedBox(width: 8), const Text('Revenue', style: TextStyle(fontSize: 12))]),
                                 const SizedBox(width: 24),
                                 Row(children: [Container(width: 12, height: 2, color: Colors.orange.shade600), const SizedBox(width: 8), const Text('Expenses', style: TextStyle(fontSize: 12))]),
                              ]
                           )
                        ]
                     ),
                     const SizedBox(height: 16),
                     SizedBox(
                        height: 300,
                        child: financialsAsync.when(
                           data: (records) => _buildDualLineChart(records),
                           loading: () => const Center(child: CircularProgressIndicator()),
                           error: (e, st) => Center(child: Text('Error loading Financials DB: \$e')),
                        )
                     ),
                  ]
               )
            ),
            const SizedBox(height: 32),
            PrimeResponsiveGrid(
               desktopMainAxisExtent: 350,
               children: [
                  PrimeCareCard(
                     child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                           const Text('Outstanding Invoices', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                           const SizedBox(height: 16),
                           Expanded(
                              child: ListView(
                                 children: [
                                    _buildInvoiceRow('Tanner Clinics INC', 'INV-8372', 45000, 32, Colors.red.shade600),
                                    _buildInvoiceRow('Northern Health System', 'INV-8373', 12500, 15, Colors.orange.shade600),
                                    _buildInvoiceRow('St. Judes Network', 'INV-8375', 5500, 4, Colors.teal.shade600),
                                    _buildInvoiceRow('West-End Medical', 'INV-8378', 8200, 1, Colors.teal.shade600),
                                 ]
                              )
                           )
                        ]
                     )
                  ),
                  PrimeCareCard(
                     child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                           const Text('Revenue by Clinic', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                           const SizedBox(height: 16),
                           Expanded(
                              child: Stack(
                                 alignment: Alignment.center,
                                 children: [
                                    SizedBox(
                                       width: 180, height: 180,
                                       child: CustomPaint(painter: _MultiLayerPiePainter())
                                    ),
                                    const Text('YTD\n\$1.4M', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
                                 ]
                              )
                           )
                        ]
                     )
                  ),
               ]
            )
          ]
        ),
      ),
    );
  }

  Widget _buildInvoiceRow(String client, String num, int val, int days, Color statusColor) {
      return Padding(
         padding: const EdgeInsets.only(bottom: 16),
         child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Row(
                  children: [
                     Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: Colors.blueGrey.shade50, borderRadius: BorderRadius.circular(8)),
                        child: Icon(Icons.receipt_long, color: Colors.blueGrey.shade700, size: 20)
                     ),
                     const SizedBox(width: 12),
                     Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(client, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                           Text(num, style: const TextStyle(color: Colors.black54, fontSize: 11)),
                        ]
                     )
                  ]
               ),
               Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                     Text('\$\$val', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                     Text('\$days days aging', style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 11)),
                  ]
               )
            ]
         )
      );
  }

  Widget _buildDualLineChart(List<dynamic> records) {
      if (records.isEmpty) return const SizedBox();
      final maxVal = records.map((e) => math.max(e['revenue'] as num, e['expenses'] as num)).reduce(math.max);
      
      final revPts = records.map((e) => (e['revenue'] as num) / maxVal).toList();
      final expPts = records.map((e) => (e['expenses'] as num) / maxVal).toList();
      final labels = records.map((e) => e['month'].toString()).toList();

      return Stack(
         children: [
            Column(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               crossAxisAlignment: CrossAxisAlignment.stretch,
               children: [
                  _ChartLineEmpty('\$\$${(maxVal).toInt()}'),
                  _ChartLineEmpty('\$\$${(maxVal * 0.75).toInt()}'),
                  _ChartLineEmpty('\$\$${(maxVal * 0.5).toInt()}'),
                  _ChartLineEmpty('\$\$${(maxVal * 0.25).toInt()}'),
                  _ChartLineEmpty('0'),
               ]
            ),
            Positioned.fill(
               child: Padding(
                  padding: const EdgeInsets.only(left: 40, right: 20, bottom: 20, top: 10),
                  child: CustomPaint(painter: _DualLineFinancialPainter(revPts, expPts))
               )
            ),
            Positioned(
               bottom: 0, left: 40, right: 20,
               child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: labels.map((l) => Text(l, style: const TextStyle(fontSize: 10, color: Colors.black54))).toList()
               )
            )
         ]
      );
  }
}

class _ChartLineEmpty extends StatelessWidget {
   final String lbl;
   const _ChartLineEmpty(this.lbl);
   @override
   Widget build(BuildContext context) {
      return Row(
         children: [
            SizedBox(width: 40, child: Text(lbl, style: const TextStyle(fontSize: 10, color: Colors.black54))),
            Expanded(child: Container(height: 1, color: Colors.grey.shade200)),
         ]
      );
   }
}

class _DualLineFinancialPainter extends CustomPainter {
   final List<double> revs;
   final List<double> exps;
   const _DualLineFinancialPainter(this.revs, this.exps);

   @override
   void paint(Canvas canvas, Size size) {
      final w = size.width / (revs.length - 1);
      final pRev = Paint()..color = Colors.teal.shade500..strokeWidth = 3..style = PaintingStyle.stroke;
      final fRev = Paint()..shader = LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.teal.shade500.withOpacity(0.3), Colors.transparent]).createShader(Rect.fromLTRB(0, 0, 0, size.height));

      final pExp = Paint()..color = Colors.orange.shade500..strokeWidth = 3..style = PaintingStyle.stroke;

      final pathR = Path()..moveTo(0, size.height * (1 - revs[0]));
      final pathE = Path()..moveTo(0, size.height * (1 - exps[0]));

      for (int i = 1; i < revs.length; i++) {
         pathR.quadraticBezierTo(w * (i - 0.5), size.height * (1 - revs[i-1]), w * i, size.height * (1 - revs[i]));
         pathE.quadraticBezierTo(w * (i - 0.5), size.height * (1 - exps[i-1]), w * i, size.height * (1 - exps[i]));
      }

      final areaR = Path.from(pathR)..lineTo(size.width, size.height)..lineTo(0, size.height)..close();
      canvas.drawPath(areaR, fRev);
      canvas.drawPath(pathR, pRev);
      canvas.drawPath(pathE, pExp);
   }
   @override bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MultiLayerPiePainter extends CustomPainter {
   @override
   void paint(Canvas canvas, Size size) {
      final center = Offset(size.width / 2, size.height / 2);
      final radius = size.width / 2;
      final rect = Rect.fromCircle(center: center, radius: radius - 16);
      
      final p1 = Paint()..color = const Color(0xFF0F4C81)..style = PaintingStyle.stroke..strokeWidth = 32;
      final p2 = Paint()..color = Colors.teal.shade500..style = PaintingStyle.stroke..strokeWidth = 32;
      final p3 = Paint()..color = Colors.orange.shade500..style = PaintingStyle.stroke..strokeWidth = 32;

      final pi2 = 3.14159 * 2;
      canvas.drawArc(rect, 0, pi2 * 0.45, false, p1);
      canvas.drawArc(rect, pi2 * 0.45, pi2 * 0.35, false, p2);
      canvas.drawArc(rect, pi2 * 0.8, pi2 * 0.2, false, p3);
   }
   @override bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
