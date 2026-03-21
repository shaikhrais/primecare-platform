import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:primecare_ui/primecare_ui.dart';

class MtInvoiceScreen extends StatelessWidget {
  const MtInvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      backgroundColor: Color(0xFFF8FAFC),
      appBar: PrimeCareNavBar(
        title: PrimeCareText('Clinical Receipt', style: TextStyle(color: PrimeCareColors.radarDark, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
        
      ),
      body: PrimeCareCenter(
        child: DesktopPaneWrapper(
          child: PrimeCareListView(
            padding: EdgeInsets.all(24),
            children: [
              PrimeCareCard(
                padding: EdgeInsets.all(32),
                
                child: PrimeCareColumn(
                  children: [
                    PrimeCareIcon(Icons.receipt_long, size: 48, color: PrimeCareColors.slate500),
                    SizedBox(height: 16),
                    PrimeCareText('Arthur Pendelton', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: PrimeCareColors.radarDark)),
                    SizedBox(height: 8),
                    PrimeCareText('Invoice #PRM-88912-XY', style: TextStyle(color: PrimeCareColors.slate400)),
                    Divider(height: 40, thickness: 1, color: PrimeCareColors.slate200),
                    _buildLineItem('Therapeutic Massage (90 Min)', '\$145.00'),
                    _buildLineItem('HST/GST (13%)', '\$18.85'),
                    Divider(height: 40, thickness: 1, color: PrimeCareColors.slate200),
                    _buildLineItem('TOTAL CHARGED', '\$163.85', isTotal: true),
                  ],
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton.icon(
                icon: PrimeCareIcon(Icons.send_rounded, color: Colors.white),
                label: PrimeCareText('EMAIL RECEIPT TO CLIENT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLineItem(String title, String cost, {bool isTotal = false}) {
    return PrimeCarePadding(
      padding: EdgeInsets.only(bottom: 12),
      child: PrimeCareRow(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PrimeCareText(title, style: TextStyle(fontWeight: isTotal ? FontWeight.w900 : FontWeight.w600, color: isTotal ? PrimeCareColors.radarDark : Color(0xFF475569), fontSize: isTotal ? 18 : 16)),
          PrimeCareText(cost, style: TextStyle(fontWeight: FontWeight.w900, color: isTotal ? PrimeCareColors.emerald : PrimeCareColors.radarDark, fontSize: isTotal ? 20 : 16)),
        ],
      ),
    );
  }
}
