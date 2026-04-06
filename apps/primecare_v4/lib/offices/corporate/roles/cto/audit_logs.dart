import 'package:flutter/material.dart';
import '../../../../theme/theme.dart';
import '../../../../theme/clinical_glass_panel.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class AuditLogsScreen extends StatelessWidget {
  const AuditLogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                   _buildKPIs(context),
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            _buildAnomalyScore(context),
                            const SizedBox(height: 24),
                            _buildPrivilegeEscalations(context),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        flex: 2,
                        child: Column(
                            children: [
                                _buildMasterLogTable(context),
                                const SizedBox(height: 24),
                                _buildGeographicMap(context),
                            ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Security & Audit Logs',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              'Immutable tracking of system changes, authentications, and escalations.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                  ),
            ),
          ],
        ),
        Row(
          children: [
            _buildActionIconButton(context, LucideIcons.download, 'Export to CSV'),
            const SizedBox(width: 12),
            _buildActionIconButton(context, LucideIcons.filter, 'Advanced Filter'),
          ],
        ),
      ],
    );
  }

  Widget _buildActionIconButton(BuildContext context, IconData icon, String tooltip) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: () {},
        tooltip: tooltip,
      ),
    );
  }

  Widget _buildKPIs(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildKPIUnit(context, 'Total Events (24h)', '142k', LucideIcons.history, 'Normal volume', PrimeCareTheme.emeraldTeal)),
        const SizedBox(width: 16),
        Expanded(child: _buildKPIUnit(context, 'Failed Logins', '24', LucideIcons.shieldAlert, 'Below threshold', PrimeCareTheme.emeraldTeal)),
        const SizedBox(width: 16),
        Expanded(child: _buildKPIUnit(context, 'Data Access Flags', '5', LucideIcons.database, 'Required admin review', Colors.orange)),
        const SizedBox(width: 16),
        Expanded(child: _buildKPIUnit(context, 'Role Changes', '12', LucideIcons.users, 'Normal administrative', Colors.blue)),
      ],
    );
  }

  Widget _buildKPIUnit(BuildContext context, String title, String value, IconData icon, String subtitle, Color color) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(icon, color: color, size: 20),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
                color: color.withValues(alpha: 0.8),
                fontSize: 12,
                fontWeight: FontWeight.w500,
            ),
           )
        ],
      ),
    );
  }

  Widget _buildMasterLogTable(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                Text(
                'Master Audit Log',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                ),
                ),
                Container(
                    width: 250,
                    height: 40,
                    decoration: BoxDecoration(
                         color: Colors.white.withValues(alpha: 0.1),
                         borderRadius: BorderRadius.circular(8),
                    ),
                    child: const TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: 'Search by User ID, IP, or Event...',
                            hintStyle: TextStyle(color: Colors.white54),
                            prefixIcon: Icon(LucideIcons.search, color: Colors.white54, size: 18),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 12),
                        )
                    )
                )
            ],
          ),
          const SizedBox(height: 24),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingTextStyle: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w600,
              ),
              dataTextStyle: const TextStyle(color: Colors.white),
              columns: const [
                DataColumn(label: Text('Timestamp')),
                DataColumn(label: Text('Event Descriptor')),
                DataColumn(label: Text('Actor (UID)')),
                DataColumn(label: Text('IP Address')),
                DataColumn(label: Text('Severity')),
              ],
              rows: [
                _buildDataRow('2026-04-06 12:45:01', 'USER_LOGIN_SUCCESS', 'usr_94b2a', '192.168.1.45', PrimeCareTheme.emeraldTeal, 'Info'),
                _buildDataRow('2026-04-06 12:42:12', 'ROLE_POLICY_UPDATE', 'adm_1a2b3', '10.0.0.5', Colors.blue, 'Low'),
                _buildDataRow('2026-04-06 12:35:44', 'DATA_EXPORT_PHI', 'usr_88c4d', '172.16.2.1', Colors.orange, 'Med'),
                _buildDataRow('2026-04-06 12:15:00', 'USER_LOGIN_FAILED_MFA', 'usr_55f9a', '45.22.1.99', Colors.redAccent, 'High'),
                _buildDataRow('2026-04-06 11:59:20', 'SYSTEM_CONFIG_CHANGE', 'sys_root', 'internal', Colors.purpleAccent, 'Crit'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildDataRow(String timestamp, String event, String actor, String ip, Color sevColor, String sev) {
    return DataRow(
      cells: [
        DataCell(Text(timestamp, style: const TextStyle(color: Colors.white70, fontSize: 12))),
        DataCell(Text(event, style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 12))),
        DataCell(Text(actor, style: const TextStyle(color: Colors.blueAccent))),
        DataCell(Text(ip)),
        DataCell(
             Container(
                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                 decoration: BoxDecoration(
                     color: sevColor.withValues(alpha: 0.2),
                     borderRadius: BorderRadius.circular(12),
                     border: Border.all(color: sevColor.withValues(alpha: 0.3)),
                 ),
                 child: Text(
                     sev.toUpperCase(),
                     style: TextStyle(
                         color: sevColor,
                         fontSize: 10,
                         fontWeight: FontWeight.w900,
                     ),
                 ),
             )
        ),
      ],
    );
  }

    Widget _buildGeographicMap(BuildContext context) {
      return ClinicalGlassPanel(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(LucideIcons.map, color: PrimeCareTheme.emeraldTeal, size: 24),
                const SizedBox(width: 12),
                Text(
                  'Geographic Authentications (24h)',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                const Text('All IPs known', style: TextStyle(color: PrimeCareTheme.emeraldTeal, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 24),
            Container(
                height: 180,
                width: double.infinity,
                 decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.1))
              ),
              child: Stack(
                  children: [
                      Center(child: Icon(LucideIcons.mapPin, size: 100, color: Colors.white.withValues(alpha: 0.05))),
                      _buildMapPin(40, 80, true), // NA
                      _buildMapPin(60, 150, true), // EU
                  ]
              )
            )
          ],
        ),
      );
    }
    
    Widget _buildMapPin(double top, double left, bool safe) {
        return Positioned(
            top: top,
            left: left,
            child: Icon(LucideIcons.mapPin, color: safe ? PrimeCareTheme.emeraldTeal : Colors.redAccent, size: 20)
        );
    }

    Widget _buildAnomalyScore(BuildContext context) {
      return ClinicalGlassPanel(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
                 Text(
                  'Platform Threat Score',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            const SizedBox(height: 24),
            Stack(
                 alignment: Alignment.center,
                 children: [
                     SizedBox(
                         height: 140,
                         width: 140,
                         child: CircularProgressIndicator(
                             value: 0.12,
                             strokeWidth: 12,
                             backgroundColor: Colors.white12,
                             valueColor: const AlwaysStoppedAnimation<Color>(PrimeCareTheme.emeraldTeal),
                         )
                     ),
                     Column(
                         children: [
                             const Text('12', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 42)),
                             Text('Low Risk', style: TextStyle(color: PrimeCareTheme.emeraldTeal.withValues(alpha: 0.8), fontSize: 14, fontWeight: FontWeight.bold)),
                         ]
                     )
                 ]
             ),
             const SizedBox(height: 24),
             const Text('AI Threat Detector actively analyzing auth behavior.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white54, fontSize: 12))
          ],
        ),
      );
    }

    Widget _buildPrivilegeEscalations(BuildContext context) {
         return ClinicalGlassPanel(
            padding: const EdgeInsets.all(24),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                     Row(
                        children: [
                            Icon(LucideIcons.arrowUpRight, color: Colors.orange, size: 24),
                            const SizedBox(width: 12),
                            Expanded(
                                child: Text(
                                'Recent Escalations',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                                ),
                            )
                        ],
                    ),
                    const SizedBox(height: 24),
                    _buildEscalationItem('Jane D. granted SystemAdmin', 'By: John S.', '2h ago', Colors.blue),
                    const Divider(color: Colors.white12, height: 24),
                    _buildEscalationItem('Temp API Key generated', 'Scope: ReadAllBilling', '5h ago', Colors.orange),
                    const Divider(color: Colors.white12, height: 24),
                    _buildEscalationItem('Service Account Elevate', 'Context: Backup Cron', '1d ago', PrimeCareTheme.emeraldTeal),
                ]
            )
        );
    }

    Widget _buildEscalationItem(String event, String context, String time, Color dotColor) {
        return Row(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
                 Container(
                     width: 10,
                     height: 10,
                     margin: const EdgeInsets.only(top: 4),
                     decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
                 ),
                 const SizedBox(width: 16),
                 Expanded(
                     child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                             Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                     Expanded(child: Text(event, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
                                     const SizedBox(width: 8),
                                     Text(time, style: const TextStyle(color: Colors.white70, fontSize: 11)),
                                 ]
                             ),
                             const SizedBox(height: 4),
                             Text(context, style: const TextStyle(color: Colors.white54, fontSize: 11)),
                         ]
                     )
                 )
             ]
        );
    }

}
