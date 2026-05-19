import 'package:primecare_ui/primecare_ui.dart';

class VirtualWaitingRoomScreen extends GovernedConsumerWidget {
  const VirtualWaitingRoomScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Virtual Waiting Room Screen'),
      ),
    );
  }
}
