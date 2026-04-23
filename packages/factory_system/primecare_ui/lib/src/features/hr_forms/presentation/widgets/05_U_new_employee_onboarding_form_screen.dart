// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class NewEmployeeOnboardingFormScreen extends ConsumerWidget {
  final dynamic data;
  
  const NewEmployeeOnboardingFormScreen({super.key, this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PrimeCareScaffold(
      title: 'newEmployeeOnboardingForm',
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(LucideIcons.component, size: 64, color: context.theme.colors.primary),
            const SizedBox(height: 16),
            Text(
              'newEmployeeOnboardingForm Implementation',
              style: context.textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text('This component is part of the hr_forms module.'),
          ],
        ),
      ),
    );
  }
}

