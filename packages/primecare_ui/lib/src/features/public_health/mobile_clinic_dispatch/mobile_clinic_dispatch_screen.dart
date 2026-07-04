import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/mobile_clinic_dispatch_header_section.dart';
import 'sections/mobile_clinic_dispatch_content_summary_section.dart';
import 'sections/mobile_clinic_dispatch_primary_content_section.dart';
import 'sections/mobile_clinic_dispatch_action_bar_section.dart';

class MobileClinicDispatchScreen extends StatelessWidget {
  const MobileClinicDispatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'mobile_clinic_dispatch',
      title: 'Mobile Clinic Dispatch',
      child: Column(
        children: const [
          const MobileClinicDispatchHeaderSection(),
          const MobileClinicDispatchContentSummarySection(),
          const MobileClinicDispatchPrimaryContentSection(),
          const MobileClinicDispatchActionBarSection(),
        ],
      ),
    );
  }
}
