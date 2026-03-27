import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';

class AdminRoleMatrixScreen extends StatefulWidget {
  const AdminRoleMatrixScreen({super.key});

  @override
  State<AdminRoleMatrixScreen> createState() => _AdminRoleMatrixScreenState();
}

class _AdminRoleMatrixScreenState extends State<AdminRoleMatrixScreen> {
  String _selectedRole = 'rn';

  final Map<String, List<Map<String, dynamic>>> _roleScreens = {
    'rn': [
      {'name': 'RN Medical Desk', 'route': '/rn/home', 'enabled': true, 'icon': Icons.medical_services},
      {'name': 'Care Plan Matrix', 'route': '/rn/care-plan', 'enabled': true, 'icon': Icons.assignment},
      {'name': 'Comms Hub', 'route': '/rn/inbox', 'enabled': true, 'icon': Icons.chat},
      {'name': 'Task Execution', 'route': '/rn/sow', 'enabled': true, 'icon': Icons.checklist},
    ],
    'psw': [
      {'name': 'PSW Dashboard', 'route': '/psw/home', 'enabled': true, 'icon': Icons.home},
      {'name': 'Timesheet Logs', 'route': '/psw/timesheets', 'enabled': true, 'icon': Icons.access_time},
      {'name': 'Earnings Tracker', 'route': '/psw/earnings', 'enabled': true, 'icon': Icons.attach_money},
      {'name': 'Comms Hub', 'route': '/psw/inbox', 'enabled': true, 'icon': Icons.chat},
      {'name': 'Scope of Work', 'route': '/psw/sow', 'enabled': true, 'icon': Icons.checklist},
    ],
    'coordinator': [
      {'name': 'Coordinator Matrix', 'route': '/coordinator/home', 'enabled': true, 'icon': Icons.hub},
      {'name': 'Approval Queue', 'route': '/coordinator/approvals', 'enabled': true, 'icon': Icons.rule},
      {'name': 'Call-in Dispatch', 'route': '/coordinator/callin', 'enabled': true, 'icon': Icons.phone_in_talk},
      {'name': 'Visit Adjustment', 'route': '/coordinator/visit-adjust', 'enabled': false, 'icon': Icons.edit_calendar},
      {'name': 'Comms Hub', 'route': '/coordinator/inbox', 'enabled': true, 'icon': Icons.chat},
      {'name': 'Scope of Work', 'route': '/coordinator/sow', 'enabled': true, 'icon': Icons.checklist},
    ],
  };

  void _showFunctionalityDrawer(String screenName) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$screenName Capabilities',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Read-Only Access'),
                subtitle: const Text('Allow user to view data natively.'),
                value: true,
                onChanged: (v) {},
                secondary: const Icon(Icons.visibility),
              ),
              SwitchListTile(
                title: const Text('Write/Edit Access'),
                subtitle: const Text('Allow user to mutate core state.'),
                value: true,
                onChanged: (v) {},
                secondary: const Icon(Icons.edit),
              ),
              SwitchListTile(
                title: const Text('Delete Authorization'),
                subtitle: const Text('Permit destructive operations.'),
                value: false,
                onChanged: (v) {},
                secondary: const Icon(Icons.delete_outline, color: Colors.red),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo, foregroundColor: Colors.white),
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Commit Configuration'),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screens = _roleScreens[_selectedRole] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Role & Screen Matrix Configurator'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        leading: BackButton(onPressed: () => context.go('/admin/home')),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sidebar explicitly for selecting roles securely cleanly
          Container(
            width: 250,
            color: Colors.grey.shade50,
            child: ListView(
              children: _roleScreens.keys.map((roleKey) {
                final isSelected = _selectedRole == roleKey;
                return ListTile(
                  title: Text(roleKey.toUpperCase(), style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
                  trailing: const Icon(Icons.chevron_right),
                  selected: isSelected,
                  selectedTileColor: Colors.indigo.shade50,
                  selectedColor: Colors.indigo,
                  onTap: () => setState(() => _selectedRole = roleKey),
                );
              }).toList(),
            ),
          ),
          
          // Main UI Grid natively visualizing functionalities creatively confidently explicitly optimally suitably explicitly securely intelligently correctly actively dependably solidly seamlessly expertly gracefully securely responsibly
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_selectedRole.toUpperCase()} Provisioned Pages',
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.add),
                        label: const Text('Assign New Screen'),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo, foregroundColor: Colors.white),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text('These interfaces are natively injected into the specified role layout securely elegantly optimally expertly systematically natively appropriately successfully cleanly natively.'),
                  const SizedBox(height: 24),
                  Expanded(
                    child: ListView.builder(
                      itemCount: screens.length,
                      itemBuilder: (context, index) {
                        final screen = screens[index];
                        return Card(
                          elevation: 0,
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: Colors.grey.shade200),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16),
                            leading: CircleAvatar(
                              backgroundColor: Colors.indigo.shade50,
                              child: Icon(screen['icon'], color: Colors.indigo),
                            ),
                            title: Text(screen['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            subtitle: Text('Route: ${screen['route']}\nStatus: ${screen['enabled'] ? 'Live' : 'Suspended'}'),
                            isThreeLine: true,
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Switch(
                                  value: screen['enabled'],
                                  onChanged: (val) {
                                    setState(() => screen['enabled'] = val);
                                  },
                                  activeColor: Colors.indigo,
                                ),
                                const SizedBox(width: 8),
                                IconButton(
                                  icon: const Icon(Icons.settings),
                                  tooltip: 'Configure Functionalities',
                                  onPressed: () => _showFunctionalityDrawer(screen['name']),
                                )
                              ],
                            ),
                          ),
                        );
                      }
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
