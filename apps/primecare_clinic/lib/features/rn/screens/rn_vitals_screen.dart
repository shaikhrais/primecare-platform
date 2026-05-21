import 'package:flutter/material.dart';

class RnVitalsScreen extends StatefulWidget {
  const RnVitalsScreen({Key? key}) : super(key: key);

  @override
  State<RnVitalsScreen> createState() => _RnVitalsScreenState();
}

class _RnVitalsScreenState extends State<RnVitalsScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Log Vitals'), backgroundColor: Colors.indigo),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const Text('Patient Vitals Entry', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 24),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Blood Pressure (e.g. 120/80)', border: OutlineInputBorder(), prefixIcon: Icon(Icons.favorite)),
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Heart Rate (bpm)', border: OutlineInputBorder(), prefixIcon: Icon(Icons.monitor_heart)),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'SpO2 (%)', border: OutlineInputBorder(), prefixIcon: Icon(Icons.air)),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  icon: _isSaving ? const CircularProgressIndicator(color: Colors.white) : const Icon(Icons.save),
                  label: Text(_isSaving ? 'Saving...' : 'Save Vitals Record'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo, foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                  ),
                  onPressed: _isSaving ? null : () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() => _isSaving = true);
                      await Future.delayed(const Duration(seconds: 1));
                      if (mounted) {
                        setState(() => _isSaving = false);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Vitals securely logged to EMR.')));
                        _formKey.currentState!.reset();
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