import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';

class PswProgressNotesScreen extends StatefulWidget {
  const PswProgressNotesScreen({super.key});

  @override
  State<PswProgressNotesScreen> createState() => _PswProgressNotesScreenState();
}

class _PswProgressNotesScreenState extends State<PswProgressNotesScreen> {
  final TextEditingController _notesController = TextEditingController();
  bool _isGenerating = false;

  void _generateAiNotes() async {
    setState(() => _isGenerating = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() {
        _isGenerating = false;
        _notesController.text = "Client was cooperative during shift. Assisted with bathing and eating 75% of meal. Mobility remained stable with walker. No complaints of pain reported.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Notes'),
        backgroundColor: const Color(0xFF1453A3),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Progress Observation', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                PrimeCareButton(
                  type: PrimeCareButtonType.text,
                  label: '✨ Auto-Draft via AI',
                  icon: Icons.auto_awesome,
                  isLoading: _isGenerating,
                  onPressed: _generateAiNotes,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TextFormField(
                controller: _notesController,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: const InputDecoration(
                  hintText: 'Enter clinical observations, client response, and plan for next shift...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 24),
            PrimeCareButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Narrative stored to Client Ledger.')));
                context.pop();
              },
              icon: Icons.checklist,
              label: 'Commit to Patient Record',
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
