// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class AlignRightIconScreen extends ConsumerWidget {
  final dynamic data;
  
  const AlignRightIconScreen({super.key, this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PrimeCareScaffold(
      title: 'alignRightIcon',
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(LucideIcons.component, size: 64, color: context.theme.colors.primary),
            const SizedBox(height: 16),
            Text(
              'alignRightIcon Implementation',
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

