import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: PrimeCareMarketingApp()));
}

class PrimeCareMarketingApp extends ConsumerWidget {
  const PrimeCareMarketingApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'PrimeCare Marketing',
      routerConfig: router,
    );
  }
}
