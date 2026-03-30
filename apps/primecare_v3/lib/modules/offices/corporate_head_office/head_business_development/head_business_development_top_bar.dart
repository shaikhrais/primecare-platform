import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/components/common_topbar_engine.dart';

class HeadBusinessDevelopmentTopBarWidget extends StatelessWidget {
  const HeadBusinessDevelopmentTopBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonTopbarEngine(
      screenTitle: 'Head of Business Development Data Core',
      onLanguageToggle: () {
        context.setLocale(context.locale == const Locale('en') ? const Locale('fr') : const Locale('en'));
      },
      onNotificationsTap: () {},
    );
  }
}
