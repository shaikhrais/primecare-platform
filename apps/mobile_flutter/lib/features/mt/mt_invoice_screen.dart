import 'package:flutter/material.dart';
import '../shared/layouts/desktop_pane_wrapper.dart';

class MtInvoiceScreen extends StatelessWidget {
  const MtInvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Clinical Receipt', style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Color(0xFF0F172A)),
      ),
      body: Center(
        child: DesktopPaneWrapper(
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE2E8F0)), boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 10, offset: Offset(0, 4))]),
                child: Column(
                  children: [
                    const Icon(Icons.receipt_long, size: 48, color: Color(0xFF64748B)),
                    const SizedBox(height: 16),
                    const Text('Arthur Pendelton', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF0F172A))),
                    const SizedBox(height: 8),
                    const Text('Invoice #PRM-88912-XY', style: TextStyle(color: Color(0xFF94A3B8))),
                    const Divider(height: 40, thickness: 1, color: Color(0xFFE2E8F0)),
                    _buildLineItem('Therapeutic Massage (90 Min)', '\$145.00'),
                    _buildLineItem('HST/GST (13%)', '\$18.85'),
                    const Divider(height: 40, thickness: 1, color: Color(0xFFE2E8F0)),
                    _buildLineItem('TOTAL CHARGED', '\$163.85', isTotal: true),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.send_rounded, color: Colors.white),
                label: const Text('EMAIL RECEIPT TO CLIENT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3B82F6), padding: const EdgeInsets.symmetric(vertical: 20), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLineItem(String title, String cost, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontWeight: isTotal ? FontWeight.w900 : FontWeight.w600, color: isTotal ? const Color(0xFF0F172A) : const Color(0xFF475569), fontSize: isTotal ? 18 : 16)),
          Text(cost, style: TextStyle(fontWeight: FontWeight.w900, color: isTotal ? const Color(0xFF10B981) : const Color(0xFF0F172A), fontSize: isTotal ? 20 : 16)),
        ],
      ),
    );
  }
}
