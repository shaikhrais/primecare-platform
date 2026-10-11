import '../localization/app_localizations.dart';
import 'package:flutter/material.dart';
import '../layout/base_primecare_layout.dart';

/// UI presentation parent. Domain rules belong in primecare_core.
abstract class BasePrimecareScreen extends BasePrimecareLayout {
  const BasePrimecareScreen({super.key});
  String get title;
  String get titleKey => "";
  Alignment get contentAlignment => Alignment.topCenter;
  double contentWidth(PrimecareLayoutData layout) => layout.contentWidth;
  Widget buildContent(BuildContext context);
  @override
  Widget buildLayout(BuildContext context, PrimecareLayoutData layout) => Scaffold(
    appBar: AppBar(leading: Navigator.canPop(context) ? IconButton(tooltip: AppStrings.of(context).text('back'), icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.maybePop(context)) : null, title: Text(titleKey.isEmpty ? title : AppStrings.of(context).text(titleKey)), actions: const [LanguageSelector()]),
    body: SafeArea(child: Align(alignment: contentAlignment, child: SizedBox(width: contentWidth(layout), child: buildContent(context)))),
  );
}
