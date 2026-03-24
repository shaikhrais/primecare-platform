import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';

class ImplementedRoute {
  final String label;
  final String path;
  final IconData icon;
  ImplementedRoute(this.label, this.path, this.icon);
}

class PendingRoute {
  final String label;
  final IconData icon;
  PendingRoute(this.label, this.icon);
}

class RoleGuideline {
  final String title;
  final String colorHex;
  final String mission;
  final String monetization;
  final String reportsTo;
  final String disciplinary;
  final List<ImplementedRoute> implementedRoutes;
  final List<PendingRoute> pendingRoutes;

  RoleGuideline({
    required this.title,
    required this.colorHex,
    required this.mission,
    required this.monetization,
    required this.reportsTo,
    required this.disciplinary,
    required this.implementedRoutes,
    required this.pendingRoutes,
  });
}

final Map<String, RoleGuideline> _roleData = {
  'psw': RoleGuideline(
    title: 'Personal Support Worker (Caregiver)',
    colorHex: '10B981', // Emerald
    mission: 'Your primary daily task is providing physical, emotional, and logistical support directly to your assigned clients securely. You must punch in using the EVV (Electronic Visit Verification) portal physically at the client\'s location.',
    monetization: 'You generate revenue by successfully logging verified hours in your Timesheet based on your hourly/visit rate natively. The agency securely invoices the LHIN/Family based entirely on your EVV punches.',
    reportsTo: 'Directly reports to the Service Coordinator. All shift issues, delays, or emergency scheduling conflicts must be routed entirely to the Coordination Hub immediately.',
    disciplinary: 'Memos or Disciplinary notices (Missed EVVs, No-Shows) are issued via your secure Inbox. Respond to warnings and supply documentation entirely through the portal.',
    implementedRoutes: [
      ImplementedRoute('Global Feed', '/psw/home', Icons.home),
      ImplementedRoute('Operations', '/psw/home', Icons.grid_view),
      ImplementedRoute('Client Roster', '/psw/clients', Icons.people),
      ImplementedRoute('Timesheets', '/psw/timesheet', Icons.timer),
      ImplementedRoute('My Profile', '/psw/profile', Icons.person),
      ImplementedRoute('Role Compass', '/psw/mentor', Icons.school),
    ],
    pendingRoutes: [
      PendingRoute('Submit Incident Report', Icons.warning_amber),
      PendingRoute('Shift Bidding Marketplace', Icons.monetization_on),
      PendingRoute('EVV GPS Diagnostics', Icons.pin_drop),
      PendingRoute('Secure Messaging', Icons.chat),
    ],
  ),
  'rn': RoleGuideline(
    title: 'Registered Nurse (Clinical Supervisor)',
    colorHex: '3B82F6', // Blue
    mission: 'You manage clinical governance. Your primary task is intaking new patients, designing Care Plans, conducting 30-day reassessments, and supervising the PSW staff deployed into the field securely.',
    monetization: 'You generate value by scaling the clinical matrix. Your approvals authorize the PSWs to perform tasks safely, reducing agency liability and enabling higher-tier skilled nursing invoice brackets.',
    reportsTo: 'Reports directly to the Clinical Manager or Director of Care (DoC). Critical medical incidents, patient emergencies or severe protocol breaches are escalated exclusively here.',
    disciplinary: 'Accountable for maintaining active regional licensing. Disciplinary actions for skipped clinical reassessments or unsigned care plans will be processed via your specific clinical inbox globally.',
    implementedRoutes: [
      ImplementedRoute('Clinical Matrix', '/rn/home', Icons.grid_view),
      ImplementedRoute('Patients Database', '/rn/home', Icons.people),
      ImplementedRoute('Secure Inbox', '/rn/inbox', Icons.inbox),
      ImplementedRoute('Clinical Profile', '/rn/profile', Icons.person),
      ImplementedRoute('Role Compass', '/rn/mentor', Icons.school),
    ],
    pendingRoutes: [
      PendingRoute('Wound Care Gallery', Icons.camera_alt),
      PendingRoute('Care Plan Builder', Icons.edit_document),
      PendingRoute('Medication Management', Icons.medication),
      PendingRoute('Direct PSW Intercom', Icons.headset_mic),
    ],
  ),
  'client': RoleGuideline(
    title: 'Client (Patient Portal)',
    colorHex: '0EA5E9', // Sky
    mission: 'This portal is designed exclusively for you or your family members to view your active care schedules, monitor health metrics natively, and ensure your services match your specific expectations.',
    monetization: 'You are the core of our business entity. Providing you outstanding care maintains our organizational health strictly.',
    reportsTo: 'If you have any issues with a Caregiver or scheduling, submit a ticket immediately to the Service Coordinator or Manager natively.',
    disciplinary: 'We have a zero-tolerance policy for abuse towards staff. Memos regarding invoice delays or service interruptions will appear directly in your Care Feed.',
    implementedRoutes: [
      ImplementedRoute('Care Feed', '/client/home', Icons.dynamic_feed),
      ImplementedRoute('Health Pulse', '/client/pulse', Icons.monitor_heart),
      ImplementedRoute('Profile Settings', '/client/profile', Icons.person),
      ImplementedRoute('Role Compass', '/client/mentor', Icons.school),
    ],
    pendingRoutes: [
      PendingRoute('Invoice Payment Portal', Icons.payment),
      PendingRoute('Family Access Delegations', Icons.family_restroom),
      PendingRoute('Request Schedule Change', Icons.event_busy),
    ],
  ),
  'coordinator': RoleGuideline(
    title: 'Service Coordinator (Dispatch)',
    colorHex: 'F59E0B', // Amber
    mission: 'You are the air-traffic controller of the agency. Day-to-Day, you are scheduling PSWs, answering call-outs, ensuring zero missed visits, and optimizing route density.',
    monetization: 'You drive revenue directly by preventing unfilled shifts. Every unstaffed shift is lost revenue. By optimizing the matching algorithm, you maximize profitability natively.',
    reportsTo: 'Reports directly to the Operations Manager and the General Manager. Daily fill-rates and drop-metrics escalate directly into their oversight matrices.',
    disciplinary: 'You are authorized to issue Level 1 Disciplinary Memos for PSW No-Shows or late EVV punches. Performance is monitored by unstaffed percentages locally.',
    implementedRoutes: [
      ImplementedRoute('Dispatch Matrix', '/coordinator/home', Icons.grid_view),
      ImplementedRoute('Staff Directory', '/coordinator/staff', Icons.people),
      ImplementedRoute('Timesheet Approvals', '/coordinator/approvals', Icons.fact_check),
      ImplementedRoute('Profile', '/coordinator/profile', Icons.person),
      ImplementedRoute('Role Compass', '/coordinator/mentor', Icons.school),
    ],
    pendingRoutes: [
      PendingRoute('Drag/Drop Scheduler', Icons.calendar_month),
      PendingRoute('Live Map Tracking', Icons.map),
      PendingRoute('Mass Call-Out Blast', Icons.campaign),
      PendingRoute('Overtime Alert Resolver', Icons.access_alarms),
    ],
  ),
  'manager': RoleGuideline(
    title: 'Operations Manager',
    colorHex: 'F43F5E', // Rose
    mission: 'You govern regional operations natively. You handle payroll approvals, complex HR disputes, hiring pipelines, and analyze overarching KPI operational fluidity strictly.',
    monetization: 'You generate revenue by optimizing overarching efficiency metrics, reducing staff turnover (which costs over two-thousand dollars per replacement), and monitoring invoice aging reports actively.',
    reportsTo: 'Reports exclusively to the General Manager (Executive Tier). You act as the shield protecting executive bandwidth.',
    disciplinary: 'You handle Level 2 Disciplinary actions natively, managing terminations, investigations, and systemic memo deployments globally.',
    implementedRoutes: [
      ImplementedRoute('Management Matrix', '/manager/home', Icons.grid_view),
      ImplementedRoute('Financial Reports', '/manager/reports', Icons.bar_chart),
      ImplementedRoute('Team Analytics', '/manager/teams', Icons.group_work),
      ImplementedRoute('Profile', '/manager/profile', Icons.person),
      ImplementedRoute('Role Compass', '/manager/mentor', Icons.school),
    ],
    pendingRoutes: [
      PendingRoute('Payroll Batch Exporter', Icons.account_balance),
      PendingRoute('HR Investigation Hub', Icons.policy),
      PendingRoute('Talent Acquisition Pipeline', Icons.person_add),
      PendingRoute('Profit/Loss Simulator', Icons.query_stats),
    ],
  ),
  'admin': RoleGuideline(
    title: 'System Command (Admin/SuperUser)',
    colorHex: '8B5CF6', // Violet
    mission: 'You maintain the structural integrity of the PrimeCare ecosystem. You manage security tokens, database migrations, network routing, and audit logs natively.',
    monetization: 'You protect value. By maintaining 99.99% uptime and ensuring strict HIPAA/SOC2 compliance globally, you prevent catastrophic fines or operational blackouts natively.',
    reportsTo: 'You operate independently or report strictly to the Executive/IT Director tier. You maintain supreme root override authority across all tenant grids globally.',
    disciplinary: 'You have the capability to instantly lock out any account, ghost any tenant, or force security expirations explicitly. All actions are indelibly logged.',
    implementedRoutes: [
      ImplementedRoute('Root Matrix', '/admin/home', Icons.grid_view),
      ImplementedRoute('Network Grid', '/admin/network', Icons.hub),
      ImplementedRoute('Security Audit', '/admin/audit', Icons.security),
      ImplementedRoute('Master Settings', '/admin/settings', Icons.settings),
      ImplementedRoute('Role Compass', '/admin/mentor', Icons.school),
    ],
    pendingRoutes: [
      PendingRoute('Live DB Query Console', Icons.terminal),
      PendingRoute('Webhook Integration Hub', Icons.webhook),
      PendingRoute('Compliance PDF Generator', Icons.picture_as_pdf),
    ],
  ),
  'mt': RoleGuideline(
    title: 'Management Team (Director Level)',
    colorHex: '14B8A6', // Teal
    mission: 'You govern client macro-relationships natively. Your focus is high-level satisfaction, negotiating regional contracts (LHIN/CCAC), and driving the organizational vision securely.',
    monetization: 'You capture massive revenue by sealing government-level contracts, expanding regional footprints, and mitigating large-scale client churn dynamically.',
    reportsTo: 'Reports to the General Manager. Collaborates closely with Operations.',
    disciplinary: 'Authorized to trigger systemic restructuring strictly mapped to operational health gradients dynamically.',
    implementedRoutes: [
      ImplementedRoute('Director Matrix', '/mt/home', Icons.grid_view),
      ImplementedRoute('Key Client Demographics', '/mt/clients', Icons.people),
      ImplementedRoute('Executive Comm-Link', '/mt/messages', Icons.chat_bubble),
      ImplementedRoute('Role Compass', '/mt/mentor', Icons.school),
    ],
    pendingRoutes: [
      PendingRoute('Contract Negotiation CRM', Icons.handshake),
      PendingRoute('Regional Expansion Map', Icons.public),
      PendingRoute('Government Billing Gateway', Icons.account_balance_wallet),
    ],
  ),
  'gm': RoleGuideline(
    title: 'General Manager (Executive Engine)',
    colorHex: '0284C7', // Oceanic Blue
    mission: 'You hold total executive command over the entire PrimeCare instance. Day-to-Day involves verifying macro-liquidity, launching new cloud tenants (Ghost Nodes), and directing strategic pivots natively.',
    monetization: 'You single-handedly drive enterprise value multipliers natively. Your decisions dictate multi-million dollar Cloudflare Worker scaling operations and enterprise platform acquisition targets dynamically.',
    reportsTo: 'The Board of Directors (if applicable). Capable of overriding any matrix state within the entire Cloudflare grid locally.',
    disciplinary: 'Maintains ultimate termination authority, organization-wide broadcast capabilities natively, and total visibility over all internal investigations globally.',
    implementedRoutes: [
      ImplementedRoute('Enterprise Matrix', '/gm/home', Icons.grid_view),
      ImplementedRoute('Role Compass', '/gm/mentor', Icons.school),
    ],
    pendingRoutes: [
      PendingRoute('Ghost Node Deployer', Icons.cloud_upload),
      PendingRoute('Executive Matrix Command V2', Icons.ssid_chart),
      PendingRoute('Cross-Tenant Analyzer', Icons.pie_chart),
      PendingRoute('Liquidity Forecast Engine', Icons.monetization_on),
    ],
  ),
  'scrum_master': RoleGuideline(
    title: 'Scrum Master / Lead Developer',
    colorHex: '9333EA', // Purple
    mission: 'You architect the software natively. You guide the AI development assistants, merge WebAssembly compilations securely, and maintain zero-trust edge deployment parity directly via Cloudflare Pages/Workers.',
    monetization: 'You literally build the tools that generate millions in revenue natively. You eliminate manual labor hours for the entire agency via algorithmic automation dynamically.',
    reportsTo: 'Chief Technology Officer (CTO) or operates as an autonomous Lead Architect directly engaging with the GM.',
    disciplinary: 'Responsible for reverting catastrophic merges seamlessly. Operates the CI/CD pipeline natively and issues technical debt notices directly to the core infrastructure team globally.',
    implementedRoutes: [
      ImplementedRoute('Sprint Matrix', '/scrum-master/home', Icons.grid_view),
      ImplementedRoute('Role Compass', '/scrum-master/mentor', Icons.school),
    ],
    pendingRoutes: [
      PendingRoute('CI/CD Log Analyzer', Icons.build),
      PendingRoute('Wrangler Deployment Hub', Icons.cloud),
      PendingRoute('WebAssembly Profiler', Icons.memory),
      PendingRoute('Ticket Backlog', Icons.bug_report),
    ],
  ),
};

class RoleMentorScreen extends StatelessWidget {
  final String rolePrefix;

  const RoleMentorScreen({super.key, required this.rolePrefix});

  @override
  Widget build(BuildContext context) {
    String key = rolePrefix.replaceAll('/', '');
    if (key == 'admin') key = 'admin'; 
    if (key.isEmpty) key = 'psw';

    final guide = _roleData[key] ?? _roleData['psw']!; 
    final primaryColor = Color(int.parse('0xFF${guide.colorHex}'));

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(guide, primaryColor),
          const SizedBox(height: 24),
          _buildMissionCard(guide, primaryColor),
          const SizedBox(height: 24),
          _buildHierarchyCard(guide, primaryColor),
          const SizedBox(height: 32),
          Text('Developer Guideline: Platform Routes', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildImplementedGrid(guide, primaryColor, context),
          const SizedBox(height: 24),
          Text('Under Construction (Pending AI Development)', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey[600])),
          const SizedBox(height: 16),
          _buildPendingGrid(guide),
          const SizedBox(height: 48),
        ],
      ),
    );
  }

  Widget _buildHeader(RoleGuideline guide, Color color) {
    return Container(
      padding: EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: color.withValues(alpha: 0.3), blurRadius: 24, offset: Offset(0, 12))
        ]
      ),
      child: Row(
        children: [
          Icon(Icons.school_rounded, size: 64, color: Colors.white),
          SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('My Role Compass', style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 16, fontWeight: FontWeight.bold)),
                Text(guide.title, style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900, height: 1.1)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMissionCard(RoleGuideline guide, Color color) {
    return PrimeCareCard(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.assignment_turned_in, color: color, size: 28),
              SizedBox(width: 12),
              Text('Day-to-Day Mission', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 16),
          Text(guide.mission, style: TextStyle(fontSize: 16, height: 1.5)),
          SizedBox(height: 32),
          Row(
            children: [
              Icon(Icons.monetization_on, color: Color(0xFF10B981), size: 28),
              SizedBox(width: 12),
              Text('How I Generate Value', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF059669))),
            ],
          ),
          SizedBox(height: 16),
          Text(guide.monetization, style: TextStyle(fontSize: 16, height: 1.5)),
        ],
      ),
    );
  }

  Widget _buildHierarchyCard(RoleGuideline guide, Color color) {
    return PrimeCareCard(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.account_tree, color: color, size: 28),
              SizedBox(width: 12),
              Text('Chain of Command & Protocols', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 16),
          Text('Reports To:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[600], fontSize: 14)),
          SizedBox(height: 4),
          Text(guide.reportsTo, style: TextStyle(fontSize: 16, height: 1.5)),
          SizedBox(height: 16),
          Text('Disciplinary & Memos:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[600], fontSize: 14)),
          SizedBox(height: 4),
          Text(guide.disciplinary, style: TextStyle(fontSize: 16, height: 1.5)),
        ],
      ),
    );
  }

  Widget _buildImplementedGrid(RoleGuideline guide, Color color, BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: guide.implementedRoutes.map((route) {
        return InkWell(
          onTap: () => context.go(route.path),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: 280,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: color.withValues(alpha: 0.3), width: 2),
              boxShadow: [
                BoxShadow(color: color.withValues(alpha: 0.1), blurRadius: 8, offset: Offset(0, 4))
              ]
            ),
            child: Row(
              children: [
                Icon(route.icon, color: color, size: 28),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(route.label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 4),
                      Text(route.path, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                    ],
                  ),
                ),
                Icon(Icons.check_circle, color: Color(0xFF10B981), size: 16)
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPendingGrid(RoleGuideline guide) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: guide.pendingRoutes.map((route) {
        return Container(
          width: 280,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey.withValues(alpha: 0.1), // Neutral
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withValues(alpha: 0.3), width: 2),
          ),
          child: Row(
            children: [
              Icon(route.icon, color: Colors.grey, size: 28),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(route.label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey)),
                    SizedBox(height: 4),
                    Text('[Under Construction]', style: TextStyle(color: Colors.orange[400], fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Icon(Icons.build_circle, color: Colors.orange[400], size: 16)
            ],
          ),
        );
      }).toList(),
    );
  }
}
