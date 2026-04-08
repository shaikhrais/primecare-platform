import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: PrimeCareBusinessDevelopmentApp()));
}

class PrimeCareBusinessDevelopmentApp extends ConsumerWidget {
  const PrimeCareBusinessDevelopmentApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'PrimeCare BusinessDevelopment',
      routerConfig: router,
    );
  }
}
