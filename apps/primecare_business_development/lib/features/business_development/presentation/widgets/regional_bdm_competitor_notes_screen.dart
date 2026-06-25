/* 
PRIME:SCREEN=regional_bdm_competitor_notes
PRIME:DESIGN=DESIGN_APPROVED
PRIME:HTML=HTML_RESPONSIVE_DONE
PRIME:COMP=COMP_REUSABLE
PRIME:LOGIC=LOGIC_WORKING
PRIME:API=API_CONNECTED
PRIME:DB=DB_NONE
PRIME:VALIDATION=VALIDATION_NONE
PRIME:QA=QA_NOT_STARTED
PRIME:FINAL=FINAL_NOT_READY
PRIME:PROGRESS=50
PRIME:BLOCKER=
PRIME:NEXT_ACTION=
*/
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'regional_bdm_competitor_notes_screen_controller.dart';

class RegionalBdmCompetitorNotesScreen extends ConsumerStatefulWidget {
  const RegionalBdmCompetitorNotesScreen({super.key});

  @override
  ConsumerState<RegionalBdmCompetitorNotesScreen> createState() => _RegionalBdmCompetitorNotesScreenState();
}

class _RegionalBdmCompetitorNotesScreenState extends ConsumerState<RegionalBdmCompetitorNotesScreen> {
  final TextEditingController _noteController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'All';
  final List<Map<String, String>> _notes = [
    {'title': 'Apex Clinic Pricing Cut', 'content': 'Apex slashed home therapy assessment pricing by 15%.', 'category': 'Pricing'},
    {'title': 'NovaHealth New Branch', 'content': 'NovaHealth opened a new clinic site in downtown Toronto.', 'category': 'Expansion'},
    {'title': 'CareFirst Ad Campaign', 'content': 'CareFirst launched a heavy digital ad campaign focusing on RMTs.', 'category': 'Marketing'},
    {'title': 'VigorRehab Plaid Integration', 'content': 'VigorRehab added Plaid banking sync to their client invoice portal.', 'category': 'Technology'},
  ];

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(regionalBdmCompetitorNotesScreenControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Regional BDM Competitor Notes'),
      ),
      body: state.when(
        data: (data) => _buildContent(context),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error loading notes telemetry: $error')),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final filteredNotes = _notes.where((note) {
      final matchesQuery = note['title']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          note['content']!.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == 'All' || note['category'] == _selectedCategory;
      return matchesQuery && matchesCategory;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Hero instructions panel
        Container(
          padding: const EdgeInsets.all(16),
          color: Theme.of(context).primaryColor.withValues(alpha: 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Competitor Analysis & Intelligence Log',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                'Track marketing campaigns, physical expansions, pricing models, and tech rollouts from competitors.',
                style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
              ),
            ],
          ),
        ),

        // Filter chips bar
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Wrap(
            spacing: 8,
            children: ['All', 'Pricing', 'Expansion', 'Marketing', 'Technology'].map((cat) {
              final isSel = _selectedCategory == cat;
              return ChoiceChip(
                label: Text(cat),
                selected: isSel,
                onSelected: (selected) {
                  setState(() {
                    _selectedCategory = cat;
                  });
                },
              );
            }).toList(),
          ),
        ),

        // Search text field
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Search intelligence log...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (val) {
              setState(() {
                _searchQuery = val;
              });
            },
          ),
        ),

        // List view of logs
        Expanded(
          child: filteredNotes.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.folder_open, size: 48, color: Colors.grey),
                      const SizedBox(height: 12),
                      const Text('No intelligence notes recorded for this category.'),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: _showAddNoteDialog,
                        child: const Text('Add Notes Entry'),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: filteredNotes.length,
                  itemBuilder: (context, index) {
                    final note = filteredNotes[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: const CircleAvatar(child: Icon(Icons.analytics)),
                        title: Text(note['title']!),
                        subtitle: Text(note['content']!),
                        trailing: Text(
                          note['category']!,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                    );
                  },
                ),
        ),

        // Floating log action button
        if (filteredNotes.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: _showAddNoteDialog,
              icon: const Icon(Icons.add),
              label: const Text('Log Competitor Intel'),
            ),
          ),
      ],
    );
  }

  void _showAddNoteDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Log Competitor Intelligence'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(
                hintText: 'Enter title/event description...',
                labelText: 'Intelligence Event',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final text = _noteController.text.trim();
              if (text.isNotEmpty) {
                setState(() {
                  _notes.add({
                    'title': text,
                    'content': 'Manually recorded intelligence log event.',
                    'category': 'Marketing',
                  });
                });
                _noteController.clear();
              }
              Navigator.pop(ctx);
            },
            child: const Text('Save Note'),
          ),
        ],
      ),
    );
  }
}
