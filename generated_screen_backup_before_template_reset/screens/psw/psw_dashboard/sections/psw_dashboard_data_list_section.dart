import 'package:primecare_ui/primecare_ui.dart';

class PswDashboardDataListSection extends ConsumerWidget {
  const PswDashboardDataListSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pswDashboardScreenProvider);
    final theme = context.theme;

    return Cy(
      id: 'section-psw_dashboard_data_list',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Assigned Clients & Visits'.tr(), style: theme.typography.h4),
          const SizedBox(height: 12),
          if (state.isLoading)
            const Center(child: CircularProgressIndicator())
          else if (state.error != null)
            Center(child: Text(state.error!, style: const TextStyle(color: Colors.red)))
          else if (state.clients.isEmpty)
            Center(
              child: Text(
                'No client visits scheduled today.'.tr(),
                style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
              ),
            )
          else
            Cy(
              id: 'psw-clients-list',
              child: Column(
                children: state.clients.map((client) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 1,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: theme.colors.primaryContainer,
                        child: Text(client.name.isNotEmpty ? client.name[0] : 'C'),
                      ),
                      title: Text(client.name, style: theme.typography.bodyLarge),
                      subtitle: Text('${client.nextVisitTime} - ${client.location}'),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: client.status == 'Urgent' ? theme.colors.errorContainer : theme.colors.successContainer,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          client.status.tr(),
                          style: TextStyle(
                            color: client.status == 'Urgent' ? theme.colors.error : theme.colors.success,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
