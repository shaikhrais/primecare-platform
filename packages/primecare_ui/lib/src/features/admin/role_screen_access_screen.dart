import 'package:primecare_ui/primecare_ui.dart';

class RoleScreenAccessScreen extends GovernedConsumerWidget {
  const RoleScreenAccessScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        title: Text(
          'Screen Access & Routing Matrix',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('UI Routing Access Control', style: theme.typography.h2),
            const SizedBox(height: 8),
            Text(
              'Map specific screens from the screen registry to available roles.',
              style: theme.typography.bodyLarge.copyWith(color: theme.colors.textSecondary),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Row(
                children: [
                  Container(
                    width: 250,
                    decoration: BoxDecoration(
                      color: theme.colors.surface,
                      border: Border.all(color: theme.colors.border),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListView(
                      children: const [
                        ListTile(title: Text('Platform Admin'), selected: true),
                        ListTile(title: Text('Clinical Director')),
                        ListTile(title: Text('HR Manager')),
                        ListTile(title: Text('Field Staff')),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        border: Border.all(color: theme.colors.border),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search Registry Screens...',
                                prefixIcon: const Icon(Icons.search),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: 20,
                              itemBuilder: (context, index) {
                                return CheckboxListTile(
                                  title: Text('SCREEN_PREMIUM_FEATURE_${index + 1}'),
                                  subtitle: const Text('View Access'),
                                  value: index % 2 == 0,
                                  onChanged: (v) {},
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
