import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';



// Hits POST /v1/registry/sync natively

class SuperuserRegistrySyncScreen extends StatelessWidget {
  const SuperuserRegistrySyncScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Global SDUI Registry',
      subtitle: 'Force-sync component hashes natively',
      icon: Icons.sync_problem,
      headerGradientColors: const [Colors.red, Colors.black87],
      kpiCards: const [
        PrimeCareKpiCard(
          title: 'Registry Drift',
          value: '0.00%',
          icon: Icons.commit,
          color: Colors.green,
        ),
        PrimeCareKpiCard(
          title: 'Remote Nodes',
          value: '14 Active',
          icon: Icons.cloud_done,
          color: Colors.lightBlue,
        ),
      ],
      children: [
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 5,
          color: Colors.grey.shade900,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.warning_amber, color: Colors.orange),
                    SizedBox(width: 8),
                    Text('DANGER ZONE', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'This terminal directly purges local component caches globally and forces mobile endpoints to reconstruct UI from the origin edge natively.',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 24),
                DropdownButtonFormField<String>(
                  value: 'ALL_REGISTRIES',
                  dropdownColor: Colors.grey.shade800,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Target Package',
                    labelStyle: TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'ALL_REGISTRIES', child: Text('Global Override (All)')),
                    DropdownMenuItem(value: 'TENANT_OVERRIDES', child: Text('Tenant-Specific Layer')),
                    DropdownMenuItem(value: 'ROLE_BINDINGS', child: Text('RBAC UI Logic Node')),
                  ],
                  onChanged: (_) {},
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Executing POST against remote edge... SYNC OK.')),
                      );
                    },
                    icon: const Icon(Icons.flash_on),
                    label: const Text('Execute Hard Sync'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
