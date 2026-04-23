// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class NavbarLayout3Screen extends ConsumerWidget {
  final dynamic data;
  
  const NavbarLayout3Screen({super.key, this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PrimeCareScaffold(
      title: 'navbarLayout3',
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(LucideIcons.component, size: 64, color: context.theme.colors.primary),
            const SizedBox(height: 16),
            Text(
              'navbarLayout3 Implementation',
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

