import 'package:flutter/material.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../core/theme/app_theme.dart';

class PaymentsView extends StatelessWidget {
  const PaymentsView({Key? key}) : super(key: key);

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
            Text('My Billing & Payments', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
            const SizedBox(height: 24),
            _buildPayRow('Monthly Care Charge (April)', '$2,400', 'PAID', Colors.teal),
            _buildPayRow('Pharmacy Out-of-Pocket', '$42.50', 'PAID', Colors.teal),
            _buildPayRow('Upcoming Physio Session', '$120.00', 'PENDING', Colors.orange),
          ],
        ),
      ),
    );
  }

  Widget _buildPayRow(String label, String value, String status, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassSurface(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            Icon(Icons.receipt_long_outlined, color: color),
            const SizedBox(width: 24),
            Expanded(child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold))),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(status, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 10)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
