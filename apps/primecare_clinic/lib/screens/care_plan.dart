import 'package:primecare_ui/primecare_ui.dart';

class CarePlanScreen extends ConsumerWidget {
  const CarePlanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Care Plan',
      subtitle: 'Review and update client care plans.',
      bodySections: [
        PrimeCard(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Text(
              'Care Plan Content',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ),
      ],
    );
  }
}
