import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/registry_entry_editor_header_section.dart';
import 'sections/registry_entry_editor_form_body_section.dart';
import 'sections/registry_entry_editor_validation_messages_section.dart';
import 'sections/registry_entry_editor_action_bar_section.dart';

class RegistryEntryEditorScreen extends StatelessWidget {
  const RegistryEntryEditorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'registry_entry_editor',
      title: 'Registry Entry Editor',
      child: Column(
        children: const [
          const RegistryEntryEditorHeaderSection(),
          const RegistryEntryEditorFormBodySection(),
          const RegistryEntryEditorValidationMessagesSection(),
          const RegistryEntryEditorActionBarSection(),
        ],
      ),
    );
  }
}
