import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/telehealth_consultation_room_header_section.dart';
import 'sections/telehealth_consultation_room_content_summary_section.dart';
import 'sections/telehealth_consultation_room_primary_content_section.dart';
import 'sections/telehealth_consultation_room_action_bar_section.dart';

class TelehealthConsultationRoomScreen extends StatelessWidget {
  const TelehealthConsultationRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'telehealth_consultation_room',
      title: 'Telehealth Consultation Room',
      child: Column(
        children: const [
          const TelehealthConsultationRoomHeaderSection(),
          const TelehealthConsultationRoomContentSummarySection(),
          const TelehealthConsultationRoomPrimaryContentSection(),
          const TelehealthConsultationRoomActionBarSection(),
        ],
      ),
    );
  }
}
