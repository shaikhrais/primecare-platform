import 'package:primecare_ui/primecare_ui.dart';

class ShiftDetailsScreen extends ConsumerWidget {
  const ShiftDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Shift Details',
      subtitle: 'View upcoming and active shifts.',
      bodySections: [
        PrimeCard(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Text(
              'Shift Details Content',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ),
      ],
    );
  }
}
