import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';

class AdminAuditScreen extends StatelessWidget {
  const AdminAuditScreen({super.key});

  final List<Map<String, String>> _shadowRoles = const [
    {'id': 'psw', 'name': 'Personal Support Worker (PSW)', 'icon': 'healing'},
    {'id': 'rn', 'name': 'Registered Nurse (RN)', 'icon': 'medical_services'},
    {'id': 'coordinator', 'name': 'Logistics Coordinator', 'icon': 'headset_mic'},
    {'id': 'manager', 'name': 'Operations Manager', 'icon': 'business_center'},
    {'id': 'client', 'name': 'Client / Family Advocate', 'icon': 'family_restroom'},
    {'id': 'gm', 'name': 'General Manager (Franchisee)', 'icon': 'account_balance'},
    {'id': 'mt', 'name': 'Medical Tech (Surge Engine)', 'icon': 'analytics'},
    {'id': 'scrum', 'name': 'Scrum Master / Agile Lead', 'icon': 'group_work'},
    {'id': 'superuser', 'name': 'Master Franchisor (Root)', 'icon': 'public'},
    {'id': 'admin', 'name': 'Network Admin', 'icon': 'admin_panel_settings'},
  ];

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'healing': return Icons.healing;
      case 'medical_services': return Icons.medical_services;
      case 'headset_mic': return Icons.headset_mic;
      case 'business_center': return Icons.business_center;
      case 'family_restroom': return Icons.family_restroom;
      case 'account_balance': return Icons.account_balance;
      case 'analytics': return Icons.analytics;
      case 'group_work': return Icons.group_work;
      case 'public': return Icons.public;
      case 'admin_panel_settings': return Icons.admin_panel_settings;
      default: return Icons.person;
    }
  }

  Future<void> _executeShadowImpersonation(BuildContext context, String roleId, String roleName) async {
    final prefs = await SharedPreferences.getInstance();
    
    // Explicitly overwrite the authenticated role profile in the secure preferences layer
    await prefs.setString('user_role', roleId);
    
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('SHADOW SUCCESS: Successfully impersonating "$roleName". Global routing re-initialized.'),
          backgroundColor: Colors.purple.shade700,
          duration: const Duration(seconds: 4),
        ),
      );
      // Reroute back to root to trigger the generic auth redirection cascade natively
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Global Shadow Audit Matrix'),
        backgroundColor: Colors.purple.shade800,
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.grey.shade100,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.purple.shade200, width: 2),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black87,
                    blurRadius: 25,
                    spreadRadius: 5,
                    offset: Offset(0, 15),
                  ),
                ],
              ),
              child: const Row(
                children: [
                  Icon(Icons.security, color: Colors.purple, size: 40),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'WARNING: You are accessing the administrative shadowing suite. Initiating a shadow sequence will aggressively rewrite your session token to inherit the exact permissions, UI, and workflows of the target persona.',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                  ),
                ],
              ),
            ),
            const Text(
              'Select Identity to Impersonate:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: _shadowRoles.length,
                itemBuilder: (context, index) {
                  final role = _shadowRoles[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black87,
                          blurRadius: 20,
                          spreadRadius: 2,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Card(
                      elevation: 0,
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      leading: CircleAvatar(
                        backgroundColor: Colors.purple.shade100,
                        child: Icon(_getIconData(role['icon']!), color: Colors.purple.shade800),
                      ),
                      title: Text(
                        role['name']!,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      subtitle: Text('System Routing Flag: ${role['id']}'),
                      trailing: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple.shade600,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () => _executeShadowImpersonation(context, role['id']!, role['name']!),
                        icon: const Icon(Icons.remove_red_eye),
                        label: const Text('Shadow Session'),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
