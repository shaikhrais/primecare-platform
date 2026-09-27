// Governance - Category: service | Purpose: Core implementation file for the Device Fleet Manager platform logic.
import 'package:primecare_ui/primecare_ui.dart';

final deviceFleetProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/admin/devices');
  return (response.data as List).cast<Map<String, dynamic>>();
});

class DeviceFleetManager extends GovernedConsumerWidget {
  const DeviceFleetManager({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final fleetState = ref.watch(deviceFleetProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        title: Text(
          'Device Fleet Manager',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(key: const Key('device_fleet_manager_iconbutton_button_1'), 
            icon: Icon(Icons.add_to_home_screen, color: theme.colors.primary),
            onPressed: () {},
            tooltip: 'Provision New Device',
          ),
          IconButton(key: const Key('device_fleet_manager_iconbutton_button_2'), 
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(deviceFleetProvider),
            tooltip: 'Refresh Device Status',
          ),
        ],
      ),
      body: fleetState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load device fleet: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (devices) => SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mobile Device Tracking & Security',
                style: theme.typography.h2.copyWith(color: theme.colors.onBackground),
              ),
              const SizedBox(height: 8),
              Text(
                'Track provisioned mobile devices used by field staff. Remote wipe capabilities available.',
                style: theme.typography.bodyLarge.copyWith(color: theme.colors.textSecondary),
              ),
              const SizedBox(height: 24),
              ResponsiveGrid(
                minItemWidth: 400,
                maxItemWidth: 600,
                spacing: 24.0,
                children: [
                  Card(
                    color: theme.colors.surface,
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Device List', style: theme.typography.h4),
                          const SizedBox(height: 16),
                          if (devices.isEmpty)
                            const Text('No devices provisioned.')
                          else
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: devices.length,
                              itemBuilder: (context, index) {
                                final device = devices[index];
                                final isOnline = device['status'] == 'Online';
                                return ListTile(
                                  leading: Icon(
                                    Icons.smartphone,
                                    color: isOnline ? theme.colors.success : theme.colors.error,
                                  ),
                                  title: Text((device['deviceName'] as String?) ?? 'Unknown Device'),
                                  subtitle: Text('Assigned: ${(device['assignedUser'] as String?) ?? 'Unassigned'}'),
                                  trailing: IconButton(key: const Key('device_fleet_manager_iconbutton_button_3'), 
                                    icon: const Icon(Icons.phonelink_erase, color: Colors.red),
                                    onPressed: () {},
                                    tooltip: 'Remote Wipe',
                                  ),
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    color: theme.colors.surface,
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Geospatial Fleet Map', style: theme.typography.h4),
                          const SizedBox(height: 16),
                          Container(
                            height: 300,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: theme.colors.background,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text('Interactive Map Component Placeholder'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
