import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: PrimeCareClinicApp()));
}

class PrimeCareClinicApp extends ConsumerWidget {
  const PrimeCareClinicApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'PrimeCare Clinic',
      routerConfig: router,
    );
  }
}
