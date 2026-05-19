import 'package:primecare_ui/primecare_ui.dart';

class DrugInteractionAlertCenterScreen extends GovernedConsumerWidget {
  const DrugInteractionAlertCenterScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Drug Interaction Alert Center Screen'),
      ),
    );
  }
}
