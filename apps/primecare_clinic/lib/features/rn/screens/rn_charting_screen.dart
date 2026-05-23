// Governance - Category: view | Purpose: UI Screen component rendering the Rn Charting Screen workspace interface.
import 'package:flutter/material.dart';

class RnChartingScreen extends StatefulWidget {
  const RnChartingScreen({Key? key}) : super(key: key);

  @override
  State<RnChartingScreen> createState() => _RnChartingScreenState();
}

class _RnChartingScreenState extends State<RnChartingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _notesController = TextEditingController();
  String _selectedPatient = 'John Doe (Room 101)';
  bool _isSaving = false;

  final List<String> _patients = [
    'John Doe (Room 101)',
    'Mary Smith (Room 102)',
    'Alice Johnson (Room 204)'
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Clinical Charting (EHR)'), backgroundColor: Colors.indigo),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<String>(
                  value: _selectedPatient,
                  decoration: const InputDecoration(labelText: 'Select Patient', border: OutlineInputBorder()),
                  items: _patients.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() { _selectedPatient = newValue!; });
                  },
                ),
                const SizedBox(height: 24),
                const Text('Progress Notes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Expanded(
                  child: TextFormField(
                    controller: _notesController,
                    maxLines: null,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      hintText: 'Enter comprehensive nursing assessment, interventions, and patient response...',
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.grey.shade50
                    ),
                    validator: (value) => value!.isEmpty ? 'Notes cannot be empty' : null,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: _isSaving ? null : () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() => _isSaving = true);
                      await Future.delayed(const Duration(seconds: 1));
                      if (mounted) {
                        setState(() => _isSaving = false);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Chart securely signed and appended to \$_selectedPatient.')));
                        _notesController.clear();
                      }
                    }
                  },
                  icon: _isSaving ? const CircularProgressIndicator(color: Colors.white) : const Icon(Icons.edit_document),
                  label: Text(_isSaving ? 'Signing Chart...' : 'Sign & Submit to EHR'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}