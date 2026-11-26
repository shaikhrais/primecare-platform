// Isolated browser acceptance host. Reuses actual login, auth state and screen;
// no synthetic authentication or communication transport is installed here.
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/auth_service.dart';
import 'package:flutter_core/communications/communication_browser_media.dart';
import 'package:primecare_ui/src/communications/communication_workspace.dart';
import 'package:primecare_ui/src/features/auth/auth_experience.dart';
import 'package:primecare_ui/src/screens/staff/communication/communication_screen.dart';
import 'package:primecare_ui/src/theme/prime_theme.dart';

SemanticsHandle? semantics;
void main() {
 WidgetsFlutterBinding.ensureInitialized();
 semantics=SemanticsBinding.instance.ensureSemantics();
 runApp(ProviderScope(overrides:[communicationMediaFactoryProvider.overrideWith((ref)=>browserCommunicationMediaFactory(configuration:{'iceServers':<Object?>[]}))],child:PrimeTheme(data:const PrimeThemeData(),child:MaterialApp(home:const StackHost()))));
}
class StackHost extends ConsumerWidget {
 const StackHost({super.key});
 @override Widget build(BuildContext context,WidgetRef ref) {
  final state=ref.watch(authProvider);
  if(!state.isInitialized)return const Scaffold(body:Center(child:CircularProgressIndicator()));
  return state.isAuthenticated?const CommunicationScreen():const PrimeAuthExperience(page:AuthPage.login);
 }
}
