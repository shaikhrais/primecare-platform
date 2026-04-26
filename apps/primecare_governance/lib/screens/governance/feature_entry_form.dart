import 'package:flutter/material.dart';

class FeatureEntryForm extends StatefulWidget {
  const FeatureEntryForm({super.key});

  @override
  State<FeatureEntryForm> createState() => _FeatureEntryFormState();
}

class _FeatureEntryFormState extends State<FeatureEntryForm> {
  final _featureByController = TextEditingController();
  final _featureNameController = TextEditingController();
  final _featureIntentController = TextEditingController();
  String _featureApp = 'PSW App';
  String _featureStatus = 'Draft';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Feature Intake',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _featureByController,
          decoration: const InputDecoration(
            labelText: 'Stakeholder / Requested By',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _featureNameController,
          decoration: const InputDecoration(
            labelText: 'Feature Name',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _featureIntentController,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: 'Intent / Business Need',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          initialValue: _featureApp,
          decoration: const InputDecoration(
            labelText: 'App',
            border: OutlineInputBorder(),
          ),
          items: [
            'PSW App',
            'Corporate Admin App',
            'Client Family App',
          ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (val) => setState(() => _featureApp = val!),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          initialValue: _featureStatus,
          decoration: const InputDecoration(
            labelText: 'Status',
            border: OutlineInputBorder(),
          ),
          items: [
            'Draft',
            'Review',
            'Approved',
            'Rejected',
          ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (val) => setState(() => _featureStatus = val!),
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Create Feature Request'),
        ),
      ],
    );
  }
}
