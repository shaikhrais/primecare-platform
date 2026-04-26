import 'package:flutter/material.dart';
import 'screens/governance/governance_data_entry_screen.dart';

void main() {
  runApp(const GovernanceApp());
}

class GovernanceApp extends StatelessWidget {
  const GovernanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PrimeCare Governance',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        scaffoldBackgroundColor: Colors.grey,
        fontFamily: 'Roboto',
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ScrollController _scrollController = ScrollController();
  String _activeTab = 'Dashboard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SIDEBAR
          Container(
            width: 280,
            color: Colors.grey,
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'PrimeCare',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Governance Control Center',
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
                const SizedBox(height: 28),
                _buildNavTitle('Control'),
                _buildNavItem('Dashboard', _activeTab == 'Dashboard'),
                _buildNavItem('Data Entry', _activeTab == 'Data Entry'),
                _buildNavItem('Feature Intake', _activeTab == 'Feature Intake'),
                _buildNavItem('Registries', _activeTab == 'Registries'),
                const SizedBox(height: 12),
                _buildNavTitle('Development'),
                _buildNavItem('Full Flow', _activeTab == 'Full Flow'),
                _buildNavItem(
                  'Source Governance',
                  _activeTab == 'Source Governance',
                ),
                _buildNavItem('Status Board', _activeTab == 'Status Board'),
                _buildNavItem('Audit', _activeTab == 'Audit'),
              ],
            ),
          ),

          // MAIN CONTENT
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TOPBAR
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.grey),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.04),
                          blurRadius: 24,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'PrimeCare Development Governance',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Data Entry & Governance control for apps, roles, screens, APIs.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: const Text(
                            'CTO / Governance Admin',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),

                  // CARDS
                  Row(
                    children: [
                      Expanded(
                        child: _buildMetricCard(
                          'Registered Apps',
                          '6',
                          '2 Active',
                          '4 Parked',
                          Colors.blue,
                          Colors.grey,
                          onTap: () => setState(() => _activeTab = 'App Entry'),
                        ),
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        child: _buildMetricCard(
                          'Roles',
                          '58',
                          '4 Active',
                          '54 Parked',
                          Colors.green,
                          Colors.orange,
                          onTap: () =>
                              setState(() => _activeTab = 'Role Entry'),
                        ),
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        child: _buildMetricCard(
                          'Microservices',
                          '8',
                          '3 Healthy',
                          '5 Unknown',
                          Colors.green,
                          Colors.red,
                          onTap: () => setState(() => _activeTab = 'API Entry'),
                        ),
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        child: _buildMetricCard(
                          'Features',
                          '12',
                          '5 Review',
                          '2 Approved',
                          Colors.purple,
                          Colors.green,
                          onTap: () =>
                              setState(() => _activeTab = 'Feature Entry'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),

                  // DATA ENTRY FORMS
                  const GovernanceDataEntryScreen(),

                  const SizedBox(height: 40),

                  // FULL FLOW
                  const Text(
                    'Full Governance Flow',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _buildCard(
                    '',
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        _buildFlowStep('Stakeholder Intent'),
                        const Text(
                          '→',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        _buildFlowStep('Data Entry'),
                        const Text(
                          '→',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        _buildFlowStep('Feature Request'),
                        const Text(
                          '→',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        _buildFlowStep('Approval'),
                        const Text(
                          '→',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        _buildFlowStep('Registry'),
                        const Text(
                          '→',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        _buildFlowStep('Code'),
                        const Text(
                          '→',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        _buildFlowStep('Test'),
                        const Text(
                          '→',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        _buildFlowStep('Release'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // REGISTRY
                  const Text(
                    'Generated Registry Example',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _buildCard(
                    '',
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        headingTextStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                        columns: const [
                          DataColumn(label: Text('ID')),
                          DataColumn(label: Text('Type')),
                          DataColumn(label: Text('Name')),
                          DataColumn(label: Text('Path / Route / API')),
                          DataColumn(label: Text('Roles')),
                          DataColumn(label: Text('Status')),
                        ],
                        rows: [
                          DataRow(
                            cells: [
                              const DataCell(Text('APP-001')),
                              const DataCell(Text('App')),
                              const DataCell(Text('Corporate Admin App')),
                              const DataCell(Text('apps/corporate_admin_app/')),
                              DataCell(
                                Row(
                                  children: [
                                    _buildBadge('CTO', Colors.blue),
                                    const SizedBox(width: 4),
                                    _buildBadge('Admin', Colors.blue),
                                  ],
                                ),
                              ),
                              DataCell(_buildBadge('Active', Colors.green)),
                            ],
                          ),
                          DataRow(
                            cells: [
                              const DataCell(Text('SCR-PSW-001')),
                              const DataCell(Text('Screen')),
                              const DataCell(Text('PSW Check-In Screen')),
                              const DataCell(
                                Text('screens/psw/psw_checkin_screen.dart'),
                              ),
                              DataCell(_buildBadge('PSW', Colors.blue)),
                              DataCell(_buildBadge('Planned', Colors.orange)),
                            ],
                          ),
                          DataRow(
                            cells: [
                              const DataCell(Text('RTE-PSW-001')),
                              const DataCell(Text('Route')),
                              const DataCell(Text('Check-In Route')),
                              const DataCell(Text('/psw/check-in')),
                              DataCell(_buildBadge('PSW', Colors.blue)),
                              DataCell(_buildBadge('Planned', Colors.orange)),
                            ],
                          ),
                          DataRow(
                            cells: [
                              const DataCell(Text('API-CHK-001')),
                              const DataCell(Text('API')),
                              const DataCell(Text('Create Check-In')),
                              const DataCell(Text('POST /api/checkins')),
                              DataCell(_buildBadge('PSW', Colors.blue)),
                              DataCell(
                                _buildBadge('Not Connected', Colors.red),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // SOURCE GOVERNANCE
                  const Text(
                    'Source-Wise Governance',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildCard(
                          'Source Folder Structure',
                          Container(
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              '''primecare/
├── apps/
│   ├── corporate_admin_app/
│   ├── psw_mobile_app/
│   ├── nurse_app/
│   ├── rmt_app/
│   └── client_family_app/
│
├── services/
│   ├── auth_service/
│   ├── user_service/
│   ├── shift_service/
│   ├── checkin_service/
│   └── reporting_service/
│
├── packages/
│   ├── shared_ui/
│   ├── shared_auth/
│   ├── shared_router/
│   ├── shared_language/
│   └── shared_api_client/
│
└── governance/
    ├── app_registry.dart
    ├── role_registry.dart
    ├── feature_intake_registry.dart
    ├── screen_registry.dart
    ├── route_registry.dart
    ├── permission_registry.dart
    ├── api_contract_registry.dart
    └── release_status_registry.dart''',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                                height: 1.6,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        child: _buildCard(
                          'Source Ownership',
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              headingTextStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                              columns: const [
                                DataColumn(label: Text('Source')),
                                DataColumn(label: Text('Owner')),
                                DataColumn(label: Text('Status')),
                              ],
                              rows: [
                                DataRow(
                                  cells: [
                                    const DataCell(
                                      Text('apps/corporate_admin_app'),
                                    ),
                                    const DataCell(Text('Admin UI Team')),
                                    DataCell(
                                      _buildBadge('Active', Colors.green),
                                    ),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    const DataCell(Text('apps/psw_mobile_app')),
                                    const DataCell(Text('Mobile Team')),
                                    DataCell(
                                      _buildBadge('Active', Colors.green),
                                    ),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    const DataCell(
                                      Text('services/auth_service'),
                                    ),
                                    const DataCell(Text('Backend Team')),
                                    DataCell(
                                      _buildBadge('Healthy', Colors.green),
                                    ),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    const DataCell(
                                      Text('services/checkin_service'),
                                    ),
                                    const DataCell(Text('Backend Team')),
                                    DataCell(
                                      _buildBadge('Unknown', Colors.red),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // STATUS BOARD
                  const Text(
                    'Development Status Board',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _buildCard(
                    '',
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildStatusColumn('Draft', [
                            'FR-012: Client family portal',
                            'FR-013: RMT visit notes',
                          ]),
                          const SizedBox(width: 14),
                          _buildStatusColumn('Review', [
                            'FR-010: PSW GPS Check-In',
                          ]),
                          const SizedBox(width: 14),
                          _buildStatusColumn('Approved', [
                            'FR-006: User Management',
                          ]),
                          const SizedBox(width: 14),
                          _buildStatusColumn('In Development', [
                            'SCR-ADM-001: User List',
                            'API-USR-001: GET /users',
                          ]),
                          const SizedBox(width: 14),
                          _buildStatusColumn('Tested / Release', [
                            'AUTH-001: Login',
                          ]),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // AUDIT
                  const Text(
                    'Governance Audit',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _buildCard(
                    '',
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        headingTextStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                        columns: const [
                          DataColumn(label: Text('Audit Check')),
                          DataColumn(label: Text('Result')),
                          DataColumn(label: Text('Meaning')),
                          DataColumn(label: Text('Fix')),
                        ],
                        rows: [
                          DataRow(
                            cells: [
                              const DataCell(Text('Every screen has route')),
                              DataCell(
                                Text(
                                  'Warning',
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const DataCell(Text('2 screens missing routes')),
                              const DataCell(Text('Add to route registry')),
                            ],
                          ),
                          DataRow(
                            cells: [
                              const DataCell(
                                Text('Every route has permission'),
                              ),
                              DataCell(
                                Text(
                                  'Failed',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const DataCell(
                                Text('/admin/reports has no role rule'),
                              ),
                              const DataCell(
                                Text('Add permission registry entry'),
                              ),
                            ],
                          ),
                          DataRow(
                            cells: [
                              const DataCell(
                                Text('Every API has health check'),
                              ),
                              DataCell(
                                Text(
                                  'Failed',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const DataCell(
                                Text('checkin_service health unknown'),
                              ),
                              const DataCell(Text('Add GET /health')),
                            ],
                          ),
                          DataRow(
                            cells: [
                              const DataCell(
                                Text('Every screen has language keys'),
                              ),
                              DataCell(
                                Text(
                                  'Warning',
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const DataCell(
                                Text('PSW Check-In missing French keys'),
                              ),
                              const DataCell(
                                Text('Add language registry keys'),
                              ),
                            ],
                          ),
                          DataRow(
                            cells: [
                              const DataCell(Text('Auth role parser active')),
                              DataCell(
                                Text(
                                  'Passed',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const DataCell(
                                Text('API role string converts to enum'),
                              ),
                              const DataCell(Text('No action')),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 22, bottom: 8),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(color: Colors.grey, fontSize: 12, letterSpacing: 1.2),
      ),
    );
  }

  Widget _buildNavItem(String title, bool isActive) {
    return InkWell(
      onTap: () => setState(() => _activeTab = title),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
        margin: const EdgeInsets.only(bottom: 6),
        decoration: BoxDecoration(
          color: isActive ? Colors.grey : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.grey,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildMetricCard(
    String title,
    String value,
    String badge1,
    String badge2,
    Color color1,
    Color color2, {
    VoidCallback? onTap,
  }) {
    return _buildCard(
      '',
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: Colors.grey, fontSize: 14)),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              _buildBadge(badge1, color1),
              const SizedBox(width: 4),
              _buildBadge(badge2, color2),
            ],
          ),
        ],
      ),
      onTap: onTap,
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _buildCard(String title, Widget child, {VoidCallback? onTap}) {
    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title.isNotEmpty) ...[
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
              ],
              child,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFlowStep(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w800,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildStatusColumn(String title, List<String> tasks) {
    return Container(
      width: 220,
      constraints: const BoxConstraints(minHeight: 180),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey, style: BorderStyle.solid),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ...tasks.map(
            (task) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Text(task, style: TextStyle(fontSize: 13)),
            ),
          ),
        ],
      ),
    );
  }
}
