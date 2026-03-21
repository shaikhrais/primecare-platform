import 'package:flutter/material.dart';
import '../../core/colors.dart';
import 'package:primecare_ui/primecare_ui.dart';


class ScrumMasterUsersScreen extends StatelessWidget {
  const ScrumMasterUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      backgroundColor: PrimeCareColors.radarDark,
      appBar: PrimeCareNavBar(
        title: const PrimeCareText('SCM_TENANT_SANDBOX', style: TextStyle(color: PrimeCareColors.purple, fontFamily: 'monospace', fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        backgroundColor: PrimeCareColors.darkMatrix,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: 15, // Dummy list
        itemBuilder: (context, index) {
          return PrimeCareCard(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            
            child: PrimeCareRow(
              children: [
                const PrimeCareIcon(Icons.storage_rounded, color: PrimeCareColors.purple, size: 32),
                const PrimeCareSizedBox(width: 16),
                PrimeCareExpanded(
                  child: PrimeCareColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PrimeCareText('TENANT_ID_${index + 1000}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'monospace')),
                      const PrimeCareSizedBox(height: 4),
                      PrimeCareText('Active Users: ${(index * 42) + 12}', style: const TextStyle(color: PrimeCareColors.slate400, fontSize: 12)),
                    ],
                  ),
                ),
                IconButton(
                  icon: const PrimeCareIcon(Icons.admin_panel_settings_rounded, color: PrimeCareColors.emerald),
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
