import 'package:flutter/material.dart';
import '../../office/components/glass_surface.dart';
import '../../core/theme/app_theme.dart';

class GlobalProfileScreen extends StatelessWidget {
  const GlobalProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('User Institutional Profile', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const CircleAvatar(radius: 50, backgroundColor: AppTheme.primary, child: Icon(Icons.person, size: 50, color: Colors.white)),
            const SizedBox(height: 24),
            Text('Authorized User', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            const Text('Institutional ID: #889221', style: TextStyle(color: Colors.blueGrey)),
            const SizedBox(height: 32),
            const GlassSurface(
              padding: EdgeInsets.all(24),
              child: Column(
                children: [
                   _ProfileRow(label: 'Email', value: 'user@primecare.v4'),
                   Divider(height: 32, thickness: 0.1),
                   _ProfileRow(label: 'Role', value: 'Authorized Personnel'),
                   Divider(height: 32, thickness: 0.1),
                   _ProfileRow(label: 'Status', value: 'ACTIVE / VERIFIED'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileRow extends StatelessWidget {
  final String label, value;
  const _ProfileRow({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}
