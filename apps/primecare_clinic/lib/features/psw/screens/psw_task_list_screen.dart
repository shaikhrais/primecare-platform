import 'package:primecare_ui/primecare_ui.dart';
import 'psw_task_list_screen_controller.dart';

class PswTaskListScreen extends ConsumerWidget {
  const PswTaskListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final title = 'PswTasksScreen';
    // ignore: unused_local_variable
    final state = ref.watch(pswTaskListScreenControllerProvider);

    return Cy(
      id: 'pswtasks-screen',
      child: Scaffold(
        backgroundColor: theme.colors.background,
        appBar: AppBar(
          title: Cy(
            id: 'pswtasks-title',
            child: const Text('PswTasks'),
          ),
        ),
        body: Semantics(
          label: 'data-cy:pswtasks-content',
          container: true,
          child: Cy(
            id: 'pswtasks-content',
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: theme.colors.surface,
                      borderRadius: BorderRadius.circular(theme.radiusMd),
                      border: Border.all(color: theme.colors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Cy(
                          id: 'pswtasks-title',
                          child: Semantics(
                            label: 'data-cy:pswtasks-title',
                            container: true,
                            button: true,
                            enabled: true,
                            onTap: () {},
                            child: Text(
                              title,
                              style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Governed operational interface to monitor patient parameters, review compliance posture, and maintain Zero-Trust synchronization.',
                          style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
