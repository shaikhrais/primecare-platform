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
    return PrimeCareScaffold(
      backgroundColor: Colors.grey[900], // Deep obsidian background for 'God Mode'
      appBar: PrimeCareNavBar(
        title: PrimeCareText(
          'Ecosystem Control Center',
          style: GoogleFonts.inter(fontWeight: FontWeight.w700, letterSpacing: -0.5, color: Colors.amberAccent),
        ),
        backgroundColor: Colors.black87,
        elevation: 0,
        actions: [
          PrimeCarePadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: PrimeCareButton(type: PrimeCareButtonType.primary, 
              onPressed: () {
                // Initiates physical POST /v1/system/global-state
              },
              
              child: const PrimeCareText('ENGAGE GLOBAL CODE BLACK'),
            ),
          )
        ],
      ),
      body: PrimeCareRow(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // LEFT COLUMN: Roles & Node Permissions
          PrimeCareExpanded(
            flex: 1,
            child: PrimeCareCard(
              padding: const EdgeInsets.all(24.0),
              
              child: PrimeCareColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PrimeCareText('Platform Roles & Access Nodes',
                      style: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                  const PrimeCareSizedBox(height: 16),
                  PrimeCareExpanded(
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
                              child: PrimeCareIcon(Icons.hub, color: Colors.black87),
                            ),
                            title: PrimeCareText(role['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            subtitle: PrimeCareText('Active Staff Nodes: ${role['staffCount']}', style: TextStyle(color: Colors.grey[400])),
                            trailing: IconButton(
                              icon: const PrimeCareIcon(Icons.edit_attributes, color: Colors.white70),
                              onPressed: () {
                                // Open complex multi-select checkboxes for Screen Array editing
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  PrimeCareButton(type: PrimeCareButtonType.primary, 
                    onPressed: () {},
                    
                    child: const PrimeCareText('+ Construct New Role'),
                  ),
                ],
              ),
            ),
          ),

          // RIGHT COLUMN: Automated Crisis Protocols
          PrimeCareExpanded(
            flex: 2,
            child: PrimeCarePadding(
              padding: const EdgeInsets.all(24.0),
              child: PrimeCareColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PrimeCareText('Active Crisis Protocols (Resolutions)',
                      style: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                  const PrimeCareSizedBox(height: 8),
                  PrimeCareText('These configurations auto-execute when anomaly thresholds are breached physically on the Edge.',
                      style: TextStyle(color: Colors.grey[400])),
                  const PrimeCareSizedBox(height: 24),
                  PrimeCareExpanded(
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
                        return PrimeCareCard(
                          padding: const EdgeInsets.all(16),
                          
                          child: PrimeCareColumn(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              PrimeCareText(protocol['scenario'],
                                  style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16)),
                              const PrimeCareSizedBox(height: 8),
                              PrimeCareRow(
                                children: [
                                  const PrimeCareIcon(Icons.bolt, color: Colors.amberAccent, size: 16),
                                  const PrimeCareSizedBox(width: 4),
                                  PrimeCareText('Trigger: ${protocol['trigger']}',
                                      style: TextStyle(color: Colors.grey[300], fontSize: 12)),
                                ],
                              ),
                              PrimeCareRow(
                                children: [
                                  const PrimeCareIcon(Icons.memory, color: Colors.cyanAccent, size: 16),
                                  const PrimeCareSizedBox(width: 4),
                                  PrimeCareText('Action: ${protocol['action']}',
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
