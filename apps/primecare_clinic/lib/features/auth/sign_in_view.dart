import 'package:primecare_ui/primecare_ui.dart';

class SignInView extends ConsumerWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('PrimeCare Clinic', style: context.theme.typography.h1),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await ref.read(authProvider.notifier).login('psw@demo.primecare.com', 'password');
              },
              child: const Text('Sign In as PSW (Demo)'),
            ),
          ],
        ),
      ),
    );
  }
}
