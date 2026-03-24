import 'package:primecare_mobile/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:primecare_ui/primecare_ui.dart';

/// The Absolute Master Home for the 'Superuser'.
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
    {'name': 'Registered Nurse', 'staffCount': 45, 'screens': ['/rn/home', '/rn/home', '/webrtc/triage']},
    {'name': 'PSW Field Op', 'staffCount': 1205, 'screens': ['/psw/home', '/psw/home', '/psw/crisis-wizard']},
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
      
      body: PrimeCareRow(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // LEFT COLUMN: Roles & Node Permissions
          PrimeCareExpanded(
            flex: 1,
            child: PrimeCareCard(
              padding: EdgeInsets.all(24.0),
              
              child: PrimeCareColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PrimeCareText('Platform Roles & Access Nodes',
                      style: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(height: 16),
                  PrimeCareExpanded(
                    child: ListView.builder(
                      itemCount: _activeRoles.length,
                      itemBuilder: (context, index) {
                        final role = _activeRoles[index];
                        return Card(
                          color: Colors.grey[850],
                          margin: EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.amberAccent,
                              child: PrimeCareIcon(Icons.hub, color: Colors.black87),
                            ),
                            title: PrimeCareText(role['name'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            subtitle: PrimeCareText('Active Staff Nodes: ${role['staffCount']}', style: TextStyle(color: Colors.grey[400])),
                            trailing: IconButton(
                              icon: PrimeCareIcon(Icons.edit_attributes, color: Colors.white70),
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
                    
                    child: PrimeCareText(AppLocalizations.of(context)!.constructNewRole),
                  ),
                ],
              ),
            ),
          ),

          // RIGHT COLUMN: Automated Crisis Protocols
          PrimeCareExpanded(
            flex: 2,
            child: PrimeCarePadding(
              padding: EdgeInsets.all(24.0),
              child: PrimeCareColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PrimeCareText('Active Crisis Protocols (Resolutions)',
                      style: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(height: 8),
                  PrimeCareText('These configurations auto-execute when anomaly thresholds are breached physically on the Edge.',
                      style: TextStyle(color: Colors.grey[400])),
                  SizedBox(height: 24),
                  PrimeCareExpanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2.5,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: _activeProtocols.length,
                      itemBuilder: (context, index) {
                        final protocol = _activeProtocols[index];
                        return PrimeCareCard(
                          padding: EdgeInsets.all(16),
                          
                          child: PrimeCareColumn(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              PrimeCareText(protocol['scenario'],
                                  style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16)),
                              SizedBox(height: 8),
                              PrimeCareRow(
                                children: [
                                  PrimeCareIcon(Icons.bolt, color: Colors.amberAccent, size: 16),
                                  SizedBox(width: 4),
                                  PrimeCareText('Trigger: ${protocol['trigger']}',
                                      style: TextStyle(color: Colors.grey[300], fontSize: 12)),
                                ],
                              ),
                              PrimeCareRow(
                                children: [
                                  PrimeCareIcon(Icons.memory, color: Colors.cyanAccent, size: 16),
                                  SizedBox(width: 4),
                                  PrimeCareText('Action: ${protocol['action']}',
                                      style: TextStyle(color: Colors.cyanAccent, fontSize: 12, fontWeight: FontWeight.bold)),
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
