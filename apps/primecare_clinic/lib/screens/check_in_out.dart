import 'package:primecare_ui/primecare_ui.dart';

class CheckInOutScreen extends ConsumerWidget {
  const CheckInOutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Check-In / Out',
      subtitle: 'Log time and attendance.',
      bodySections: [
        PrimeCard(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Text(
              'Check-In / Out Content',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ),
      ],
    );
  }
}
