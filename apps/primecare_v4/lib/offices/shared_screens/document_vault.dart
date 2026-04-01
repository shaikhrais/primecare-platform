import 'package:flutter/material.dart';
import '../../office/components/glass_surface.dart';
import '../../core/theme/app_theme.dart';

class DocumentVaultScreen extends StatelessWidget {
  const DocumentVaultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('Secure Institutional Vault', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildDocItem('Arthur_Dent_Discharge_Pack.pdf', 'Clinical', '2.4 MB', Colors.teal),
          _buildDocItem('Institutional_Security_Audit_2026.pdf', 'Compliance', '12.1 MB', Colors.indigo),
          _buildDocItem('Quarterly_Financial_Aggregated.xlsx', 'Finance', '1.1 MB', Colors.orange),
        ],
      ),
    );
  }

  Widget _buildDocItem(String name, String cat, String size, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassSurface(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(Icons.description_outlined, color: color),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(cat, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 10)),
                ],
              ),
            ),
            Text(size, style: const TextStyle(color: Colors.blueGrey, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
