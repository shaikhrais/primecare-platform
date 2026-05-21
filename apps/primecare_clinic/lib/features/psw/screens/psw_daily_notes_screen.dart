import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PswDailyNotesScreen extends StatefulWidget {
  const PswDailyNotesScreen({Key? key}) : super(key: key);

  @override
  State<PswDailyNotesScreen> createState() => _PswDailyNotesScreenState();
}

class _PswDailyNotesScreenState extends State<PswDailyNotesScreen> {
  final _formKey = GlobalKey<FormState>();
  final _noteController = TextEditingController();
  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Log Daily Notes'), backgroundColor: Colors.teal),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Observations', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _noteController,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: 'Enter clinical observations, patient mood, and vitals here...', 
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    filled: true,
                    fillColor: Colors.grey.shade50
                  ),
                  validator: (value) => value == null || value.isEmpty ? 'Notes cannot be empty.' : null,
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  icon: _isSaving ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) : const Icon(Icons.save),
                  label: Text(_isSaving ? 'Saving to EMR...' : 'Submit Note'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal, 
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                  ),
                  onPressed: _isSaving ? null : () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() => _isSaving = true);
                      await Future.delayed(const Duration(seconds: 1)); // Simulate API Call
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Note successfully synchronized to patient record!'), backgroundColor: Colors.green));
                        context.go('/clinic/dashboard');
                      }
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}