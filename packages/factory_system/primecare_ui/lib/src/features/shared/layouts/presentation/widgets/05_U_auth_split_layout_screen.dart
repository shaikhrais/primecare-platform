// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class AuthSplitLayoutScreen extends ConsumerWidget {
  final dynamic data;
  
  const AuthSplitLayoutScreen({super.key, this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PrimeCareScaffold(
      title: 'authSplitLayout',
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(LucideIcons.component, size: 64, color: context.theme.colors.primary),
            const SizedBox(height: 16),
            Text(
              'authSplitLayout Implementation',
              style: context.textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text('This component is part of the shared/layouts module.'),
          ],
        ),
      ),
    );
  }
}

