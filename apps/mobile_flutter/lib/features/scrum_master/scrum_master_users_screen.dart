import 'package:flutter/material.dart';

class ScrumMasterUsersScreen extends StatelessWidget {
  const ScrumMasterUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text('SCM_TENANT_SANDBOX', style: TextStyle(color: Color(0xFF8B5CF6), fontFamily: 'monospace', fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        backgroundColor: const Color(0xFF020617),
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
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF334155)),
              boxShadow: [BoxShadow(color: Colors.black.withAlpha(50), blurRadius: 10, offset: const Offset(0, 4))],
            ),
            child: Row(
              children: [
                const Icon(Icons.storage_rounded, color: Color(0xFF8B5CF6), size: 32),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('TENANT_ID_${index + 1000}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'monospace')),
                      const SizedBox(height: 4),
                      Text('Active Users: ${(index * 42) + 12}', style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12)),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.admin_panel_settings_rounded, color: Color(0xFF10B981)),
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
