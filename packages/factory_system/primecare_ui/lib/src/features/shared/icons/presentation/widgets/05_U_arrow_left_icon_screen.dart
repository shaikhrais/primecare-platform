// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class ArrowLeftIconScreen extends ConsumerWidget {
  final dynamic data;
  
  const ArrowLeftIconScreen({super.key, this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PrimeCareScaffold(
      title: 'arrowLeftIcon',
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(LucideIcons.component, size: 64, color: context.theme.colors.primary),
            const SizedBox(height: 16),
            Text(
              'arrowLeftIcon Implementation',
              style: context.textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text('This component is part of the shared/icons module.'),
          ],
        ),
      ),
    );
  }
}

