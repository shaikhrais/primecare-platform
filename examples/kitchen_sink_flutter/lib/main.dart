import 'package:flutter/material.dart';
import 'package:primecare_master/kitchen_sink.dart';

void main() => runApp(const KitchenSinkExample());

class KitchenSinkExample extends StatefulWidget {
  const KitchenSinkExample({super.key});
  @override
  State<KitchenSinkExample> createState() => _KitchenSinkExampleState();
}

class _KitchenSinkExampleState extends State<KitchenSinkExample> {
  ThemeMode mode = ThemeMode.light;
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: kitchenSinkTheme(),
    darkTheme: kitchenSinkTheme(dark: true),
    themeMode: mode,
    home: PrimeKitchenSinkGallery(
      onToggleTheme: () => setState(
        () => mode = mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light,
      ),
    ),
  );
}
