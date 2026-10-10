import '../localization/app_localizations.dart';
import 'package:flutter/material.dart';

/// UI presentation parent. Domain rules belong in primecare_core.
abstract class BasePrimecareScreen extends StatelessWidget {
  const BasePrimecareScreen({super.key});
  String get title;
  String get titleKey => "";
  Widget buildContent(BuildContext context);
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(leading: Navigator.canPop(context) ? IconButton(tooltip: AppStrings.of(context).text('back'), icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.maybePop(context)) : null, title: Text(titleKey.isEmpty ? title : AppStrings.of(context).text(titleKey)), actions: const [LanguageSelector()]),
    body: SafeArea(child: buildContent(context)),
  );
}
