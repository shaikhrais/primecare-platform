import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/research_publication_drafting_header_section.dart';
import 'sections/research_publication_drafting_filter_bar_section.dart';
import 'sections/research_publication_drafting_data_table_section.dart';
import 'sections/research_publication_drafting_pagination_section.dart';
import 'sections/research_publication_drafting_action_bar_section.dart';

class ResearchPublicationDraftingScreen extends StatelessWidget {
  const ResearchPublicationDraftingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'research_publication_drafting',
      title: 'Research Publication Drafting',
      child: Column(
        children: const [
          const ResearchPublicationDraftingHeaderSection(),
          const ResearchPublicationDraftingFilterBarSection(),
          const ResearchPublicationDraftingDataTableSection(),
          const ResearchPublicationDraftingPaginationSection(),
          const ResearchPublicationDraftingActionBarSection(),
        ],
      ),
    );
  }
}
