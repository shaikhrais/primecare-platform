import 'package:primecare_ui/primecare_ui.dart';

class PublicHealthAlertBroadcasterScreen extends GovernedConsumerWidget {
  const PublicHealthAlertBroadcasterScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Public Health Alert Broadcaster Screen'),
      ),
    );
  }
}
