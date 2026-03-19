import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'psw_client_360_screen.dart';

class PswClientsScreen extends StatelessWidget {
  const PswClientsScreen({super.key});

  final List<Map<String, String>> _clients = const [
    {'id': 'c_1', 'name': 'Sarah Jenkins', 'status': 'Stable', 'address': '123 Main St, Toronto'},
    {'id': 'c_2', 'name': 'Robert Kiyosaki', 'status': 'Monitoring', 'address': '44 Financial Ave, York'},
    {'id': 'c_3', 'name': 'Eliza Thornberry', 'status': 'Critical', 'address': '99 Safari Rd, Etobicoke'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(
          'Assigned Clients', 
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 120), // Bottom padding for nanobannab
        itemCount: _clients.length,
        itemBuilder: (context, index) {
          final client = _clients[index];
          final isCritical = client['status'] == 'Critical';
          final statusColor = isCritical ? const Color(0xFFE11D48) : const Color(0xFF10B981);

          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: InkWell(
              onTap: () {
                HapticFeedback.lightImpact();
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => PswClient360Screen(clientId: client['id']!, clientName: client['name']!))
                );
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 16, offset: Offset(0, 4))],
                ),
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: const Color(0xFFE2E8F0),
                      child: Text(
                        client['name']!.substring(0, 1), 
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Color(0xFF0F172A))
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(client['name']!, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Color(0xFF0F172A))),
                          const SizedBox(height: 4),
                          Text(client['address']!, style: const TextStyle(color: Color(0xFF64748B), fontSize: 14)),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Container(
                                width: 8, height: 8,
                                decoration: BoxDecoration(shape: BoxShape.circle, color: statusColor),
                              ),
                              const SizedBox(width: 6),
                              Text(client['status']!, style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 13)),
                            ],
                          )
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFFCBD5E1), size: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
