import 'package:primecare_ui/primecare_ui.dart';

class ControlledSubstanceLogScreen extends GovernedConsumerWidget {
  const ControlledSubstanceLogScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Controlled Substance Log Screen'),
      ),
    );
  }
}
