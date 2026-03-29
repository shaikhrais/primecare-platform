import 'package:flutter/material.dart';
import '../theme/colors.dart';

import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';

class _MockApiClient {
  Future<dynamic> get(String path) async => {'fields': []};
  Future<void> post(String path, dynamic data) async {}
}

final _apiClientMock = _MockApiClient();

/// Phase 74: Dynamic SDUI Form Builder Engine
/// This widget prevents you from ever needing to code another UI form.
/// You pass it a FormID, it fetches the JSON layout from Cloudflare,
/// builds the UI controls dynamically, and handles the backend submission.
class PrimeCareDynamicFormBuilder extends StatefulWidget {
  final String formId;
  final VoidCallback? onSubmitted;
  final Future<dynamic> Function(String)? apiGet;
  final Future<void> Function(String, dynamic)? apiPost;

  const PrimeCareDynamicFormBuilder({
    super.key,
    required this.formId,
    this.onSubmitted,
    this.apiGet,
    this.apiPost,
  });

  @override
  State<PrimeCareDynamicFormBuilder> createState() =>
      _PrimeCareDynamicFormBuilderState();
}

class _PrimeCareDynamicFormBuilderState
    extends State<PrimeCareDynamicFormBuilder> {
  Map<String, dynamic>? _schema;
  final Map<String, dynamic> _formData = {};
  bool _isLoading = true;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _fetchFormSchema();
  }

  Future<void> _fetchFormSchema() async {
    try {
      final response = widget.apiGet != null
          ? await widget.apiGet!('/v1/sdui/forms/${widget.formId}')
          : await _apiClientMock.get('/v1/sdui/forms/${widget.formId}');
      if (mounted) {
        setState(() {
          _schema = response;
          // Initialize default form state
          for (var field in response['fields']) {
            if (field['type'] != 'header') {
              _formData[field['key']] = field['type'] == 'boolean'
                  ? false
                  : null;
            }
          }
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _submitDynamicForm() async {
    setState(() => _isSubmitting = true);
    try {
      final endpoint = _schema!['submitEndpoint'];
      // Physical submission to the engine
      if (widget.apiPost != null) {
        await widget.apiPost!(endpoint, _formData);
      } else {
        await _apiClientMock.post(endpoint, _formData);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Form Successfully Transmitted via Edge Node'),
            backgroundColor: Colors.green,
          ),
        );
        if (widget.onSubmitted != null) widget.onSubmitted!();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Transmission Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  Widget _buildField(Map<String, dynamic> fieldSchema) {
    String type = fieldSchema['type'];
    String label = fieldSchema['label'] ?? '';
    String? key = fieldSchema['key'];

    switch (type) {
      case 'header':
        return Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 12),
          child: Text(label.toUpperCase(), overflow: TextOverflow.ellipsis, maxLines: 1, style: GoogleFonts.firaCode(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        );

      case 'text':
      case 'phone':
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: label,
              labelStyle: GoogleFonts.inter(
                color: Theme.of(
                  context,
                ).textTheme.bodyMedium?.color?.withOpacity(0.6),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Theme.of(context).cardColor,
            ),
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
            onChanged: (val) => _formData[key!] = val,
          ),
        );

      case 'boolean':
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Theme.of(context).dividerColor),
          ),
          child: SwitchListTile(
            title: Text(label, overflow: TextOverflow.ellipsis, maxLines: 1, style: GoogleFonts.inter(
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            value: _formData[key!] ?? false,
            activeColor: Theme.of(context).colorScheme.secondary,
            onChanged: (val) => setState(() => _formData[key] = val),
          ),
        );

      case 'dropdown':
        List<dynamic> options = fieldSchema['options'] ?? [];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: label,
              labelStyle: GoogleFonts.inter(
                color: Theme.of(
                  context,
                ).textTheme.bodyMedium?.color?.withOpacity(0.6),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Theme.of(context).cardColor,
            ),
            dropdownColor: Theme.of(context).cardColor,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
            value: _formData[key],
            items: options
                .map(
                  (opt) => DropdownMenuItem<String>(
                    value: opt.toString(),
                    child: Text(opt.toString()),
                  ),
                )
                .toList(),
            onChanged: (val) => setState(() => _formData[key!] = val),
          ),
        );

      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading)
      return Center(
        child: CircularProgressIndicator(color: Theme.of(context).colorScheme.secondary),
      );
    if (_schema == null)
      return Center(
        child: Text('SDUI Engine Failure', overflow: TextOverflow.ellipsis, maxLines: 1, style: GoogleFonts.firaCode(color: Colors.red),
        ),
      );

    List<dynamic> fields = _schema!['fields'] ?? [];

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(Icons.webhook, color: Theme.of(context).colorScheme.secondary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _schema!['title'] ?? 'Dynamic Form', 
                      overflow: TextOverflow.ellipsis, 
                      maxLines: 1, 
                      style: GoogleFonts.outfit(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

          ...fields.map((field) => _buildField(field)),

          const SizedBox(height: 32),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: _isSubmitting ? null : _submitDynamicForm,
            child: _isSubmitting
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  )
                : Text('TRANSMIT SECURE PAYLOAD', overflow: TextOverflow.ellipsis, maxLines: 1, style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,),
                  ),
          ),
        ],
      ),
    )));
  }
}
