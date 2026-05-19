import 'package:primecare_ui/primecare_ui.dart';

class InformedConsentTrackerScreen extends GovernedConsumerWidget {
  const InformedConsentTrackerScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Informed Consent Tracker Screen'),
      ),
    );
  }
}
