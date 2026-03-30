import 'package:flutter/material.dart';
import 'form_schema_loader.dart';
// Note: Intercepts raw UI structure here via dynamic_form_builder.

class FormRendererAdapter extends StatefulWidget {
  final String formId;
  const FormRendererAdapter({super.key, required this.formId});

  @override
  State<FormRendererAdapter> createState() => _FormRendererAdapterState();
}

class _FormRendererAdapterState extends State<FormRendererAdapter> {
  Map<String, dynamic>? _schema;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchSchema();
  }

  Future<void> _fetchSchema() async {
    final payload = await FormSchemaLoader.loadSchema(widget.formId);
    if (mounted) {
      setState(() {
        _schema = payload;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_schema == null) {
      return const Center(child: Text('Engine Failed to Load Schema.'));
    }

    final fields = _schema!['fields'] as List<dynamic>;

    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
         color: Colors.white,
         borderRadius: BorderRadius.circular(12),
         border: Border.all(color: Colors.blue.shade100)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(_schema!['title'], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
          const SizedBox(height: 8),
          Text(_schema!['description'], style: const TextStyle(fontSize: 16, color: Colors.grey)),
          const SizedBox(height: 32),
          
          Expanded(
            child: ListView.separated(
               physics: const BouncingScrollPhysics(),
               itemCount: fields.length,
               separatorBuilder: (_, __) => const SizedBox(height: 24),
               itemBuilder: (context, index) {
                 final f = fields[index];
                 // Core stub mapping dynamic_form_builder components dynamically
                 return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Row(
                         children: [
                           Text(f['label'], style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                           if (f['required'] == true) const Text(' *', style: TextStyle(color: Colors.red)),
                         ]
                       ),
                       const SizedBox(height: 8),
                       _buildMockInputMapping(f)
                    ]
                 );
               },
            ),
          ),

          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
               // Submits telemetry logic
               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("\${_schema!['title']} Submitted Safely!")));
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.blueAccent,
            ),
            child: const Text('Save Form Telemetry', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          )
        ]
      )
    );
  }

  Widget _buildMockInputMapping(dynamic f) {
     final type = f['type'];
     if (type == 'textarea') {
         return TextField(maxLines: 4, decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))));
     } else if (type == 'checkbox') {
         return CheckboxListTile(title: const Text('Confirm'), value: false, onChanged: (v) {});
     } else if (type == 'dropdown') {
         return DropdownButtonFormField<String>(
            decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
            items: (f['options'] as List<dynamic>).map((e) => DropdownMenuItem<String>(value: e.toString(), child: Text(e.toString()))).toList(),
            onChanged: (v) {},
         );
     }
     
     // default text/number/time mapping
     return TextField(decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))));
  }
}
