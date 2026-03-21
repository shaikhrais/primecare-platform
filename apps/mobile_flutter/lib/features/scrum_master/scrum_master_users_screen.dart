import 'package:flutter/material.dart';
import '../../core/colors.dart';


class ScrumMasterUsersScreen extends StatelessWidget {
  const ScrumMasterUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PrimeCareColors.radarDark,
      appBar: AppBar(
        title: const Text('SCM_TENANT_SANDBOX', style: TextStyle(color: PrimeCareColors.purple, fontFamily: 'monospace', fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        backgroundColor: PrimeCareColors.darkMatrix,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: 15, // Dummy list
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: PrimeCareColors.slate800,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: PrimeCareColors.slate700),
              boxShadow: [BoxShadow(color: Colors.black.withAlpha(50), blurRadius: 10, offset: const Offset(0, 4))],
            ),
            child: Row(
              children: [
                const Icon(Icons.storage_rounded, color: PrimeCareColors.purple, size: 32),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('TENANT_ID_${index + 1000}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'monospace')),
                      const SizedBox(height: 4),
                      Text('Active Users: ${(index * 42) + 12}', style: const TextStyle(color: PrimeCareColors.slate400, fontSize: 12)),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.admin_panel_settings_rounded, color: PrimeCareColors.emerald),
                  onPressed: () {},
                  tooltip: 'Impersonate Tenant',
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
