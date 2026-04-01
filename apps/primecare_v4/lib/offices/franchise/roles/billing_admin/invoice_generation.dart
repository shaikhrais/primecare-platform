import 'package:flutter/material.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../core/theme/app_theme.dart';

class InvoiceGenerationView extends StatelessWidget {
  const InvoiceGenerationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ledger Reconciliation & Invoicing', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
            const SizedBox(height: 24),
            _buildInvoiceBlock('Pending Batch: Clinical Services', r'$142K', 'Ready', Colors.teal),
            _buildInvoiceBlock('Pending Batch: Pharma Claims', r'$42K', 'Auditing', Colors.orange),
            _buildInvoiceBlock('Automated Monthly Billing', 'Active', 'Stable', Colors.indigo),
          ],
        ),
      ),
    );
  }

  Widget _buildInvoiceBlock(String title, String val, String status, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassSurface(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            Icon(Icons.account_balance_wallet_outlined, color: color),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(status, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 10)),
                ],
              ),
            ),
            Text(val, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
