import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/components/common_topbar_engine.dart';

class ClientTopBarWidget extends StatelessWidget {
  const ClientTopBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonTopbarEngine(
      screenTitle: 'Client Data Core',
      onLanguageToggle: () {
        context.setLocale(context.locale == const Locale('en') ? const Locale('fr') : const Locale('en'));
      },
      onNotificationsTap: () {},
    );
  }
}
