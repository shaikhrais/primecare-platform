import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:primecare_ui/primecare_ui.dart';

/// The Absolute Master Dashboard for the 'Superuser'.
/// This screen allows the creation of net-new platform Roles and
/// the mapping of Crisis Protocols to physical UI overrides natively.
class EcosystemControlCenterScreen extends StatefulWidget {
  const EcosystemControlCenterScreen({super.key});

  @override
  State<EcosystemControlCenterScreen> createState() => _EcosystemControlCenterScreenState();
}

class _EcosystemControlCenterScreenState extends State<EcosystemControlCenterScreen> {
  // Temporary mock payload representing Cloudflare Edge GET /v1/system/ecosystem/*
  final List<Map<String, dynamic>> _activeRoles = [
    {'name': 'Coordinator', 'staffCount': 142, 'screens': ['/coordinator/live-map', '/coordinator/jane-matrix']},
    {'name': 'Registered Nurse', 'staffCount': 45, 'screens': ['/rn/dashboard', '/rn/patients', '/webrtc/triage']},
    {'name': 'PSW Field Op', 'staffCount': 1205, 'screens': ['/psw/dashboard', '/psw/live-visit', '/psw/crisis-wizard']},
  ];

  final List<Map<String, dynamic>> _activeProtocols = [
    {
      'scenario': 'Offline Connectivity Drop',
      'trigger': 'EVV_TIMEOUT',
      'action': 'ENABLE_SQLITE_BUFFER',
      'severity': 'Medium'
    },
    {
      'scenario': 'Severe Geo-Anomaly (Sprinting)',
      'trigger': 'LAT_LNG_SPEED_SPIKE',
      'action': 'PROMPT_ARE_YOU_OKAY',
      'severity': 'High'
    },
    {
      'scenario': 'Code Black - Structural Shortage',
      'trigger': 'SHIFT_UNSTAFFED_THRESHOLD',
      'action': 'ENABLE_HAZARD_PAY_2X',
      'severity': 'Critical'
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Relying on a Universal Split-Pane layout standard for Desktop/Tablet Executive views
    return Scaffold(
      backgroundColor: Colors.grey[900], // Deep obsidian background for 'God Mode'
      appBar: AppBar(
        title: Text(
          'Ecosystem Control Center',
          style: GoogleFonts.inter(fontWeight: FontWeight.w700, letterSpacing: -0.5, color: Colors.amberAccent),
        ),
        backgroundColor: Colors.black87,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Initiates physical POST /v1/system/global-state
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              child: const Text('ENGAGE GLOBAL CODE BLACK'),
            ),
          )
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // LEFT COLUMN: Roles & Node Permissions
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                border: Border(right: BorderSide(color: Colors.grey[800]!)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Platform Roles & Access Nodes',
                      style: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _activeRoles.length,
                      itemBuilder: (context, index) {
                        final role = _activeRoles[index];
                        return Card(
                          color: Colors.grey[850],
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            leading: const CircleAvatar(
                              backgroundColor: Colors.amberAccent,
                              child: Icon(Icons.hub, color: Colors.black87),
                            ),
                            title: Text(role['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            subtitle: Text('Active Staff Nodes: ${role['staffCount']}', style: TextStyle(color: Colors.grey[400])),
                            trailing: IconButton(
                              icon: const Icon(Icons.edit_attributes, color: Colors.white70),
                              onPressed: () {
                                // Open complex multi-select checkboxes for Screen Array editing
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey[700]),
                    child: const Text('+ Construct New Role'),
                  ),
                ],
              ),
            ),
          ),

          // RIGHT COLUMN: Automated Crisis Protocols
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Active Crisis Protocols (Resolutions)',
                      style: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 8),
                  Text('These configurations auto-execute when anomaly thresholds are breached physically on the Edge.',
                      style: TextStyle(color: Colors.grey[400])),
                  const SizedBox(height: 24),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2.5,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: _activeProtocols.length,
                      itemBuilder: (context, index) {
                        final protocol = _activeProtocols[index];
                        return Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.black45,
                            border: Border.all(
                                color: protocol['severity'] == 'Critical' ? Colors.redAccent : Colors.amberAccent,
                                width: 1.5),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(protocol['scenario'],
                                  style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16)),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.bolt, color: Colors.amberAccent, size: 16),
                                  const SizedBox(width: 4),
                                  Text('Trigger: ${protocol['trigger']}',
                                      style: TextStyle(color: Colors.grey[300], fontSize: 12)),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.memory, color: Colors.cyanAccent, size: 16),
                                  const SizedBox(width: 4),
                                  Text('Action: ${protocol['action']}',
                                      style: const TextStyle(color: Colors.cyanAccent, fontSize: 12, fontWeight: FontWeight.bold)),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
