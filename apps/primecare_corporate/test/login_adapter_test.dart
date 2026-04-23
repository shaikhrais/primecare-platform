import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/primecare_ui.dart';

void main() {
  testWidgets('Check if Login screen renders and has input fields', (
    tester,
  ) async {
    // Inject mock auth provider if necessary
    // Increase default test window size to prevent RenderFlex overflow errors
    // with the responsive AuthLayout Split layout
    tester.view.physicalSize = const Size(1920, 1080);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(home: const Scaffold(body: LoginScreen())),
      ),
    );

    await tester.pumpAndSettle();

    // The LoginScreen uses easy_localization, which might show the fallback missing keys,
    // or we can test using Finder for TextFields

    // Look for Email and Password TextFields
    final textFields = find.byType(TextField);
    expect(textFields, findsWidgets); // Should find Email and Password fields

    // Look for Login/Sign In Button
    final button = find.byType(ElevatedButton);
    expect(button, findsWidgets);
  });
}
