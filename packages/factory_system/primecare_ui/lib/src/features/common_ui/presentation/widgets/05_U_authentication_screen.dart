// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class AuthenticationScreen extends ConsumerWidget {
  final dynamic data;
  
  const AuthenticationScreen({super.key, this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PrimeCareScaffold(
      title: 'authentication',
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(LucideIcons.component, size: 64, color: context.theme.colors.primary),
            const SizedBox(height: 16),
            Text(
              'authentication Implementation',
              style: context.textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text('This component is part of the common_ui module.'),
          ],
        ),
      ),
    );
  }
}

