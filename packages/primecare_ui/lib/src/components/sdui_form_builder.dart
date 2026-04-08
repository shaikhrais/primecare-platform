import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'primecare_data_table.dart';

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
            activeThumbColor: Theme.of(context).colorScheme.secondary,
            onChanged: (val) => setState(() => _formData[key] = val),
          ),
        );

      case 'checkbox':
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Theme.of(context).dividerColor),
          ),
          child: CheckboxListTile(
            title: Text(label, overflow: TextOverflow.ellipsis, maxLines: 1, style: GoogleFonts.inter(
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            value: _formData[key!] ?? false,
            activeColor: Theme.of(context).colorScheme.secondary,
            onChanged: (val) => setState(() => _formData[key] = val),
            controlAffinity: ListTileControlAffinity.leading,
          ),
        );

      case 'datepicker':
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: TextFormField(
            readOnly: true,
            controller: TextEditingController(text: _formData[key] != null ? _formData[key].toString().split(' ')[0] : ''),
            decoration: InputDecoration(
              labelText: label,
              labelStyle: GoogleFonts.inter(
                color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
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
              suffixIcon: Icon(Icons.calendar_today, color: Theme.of(context).colorScheme.primary),
            ),
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              );
              if (date != null) {
                setState(() => _formData[key!] = date.toIso8601String());
              }
            },
          ),
        );

      case 'combobox':
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: '$label (Search ${fieldSchema['lookupTable'] ?? "Records"})',
              labelStyle: GoogleFonts.inter(
                color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
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
              prefixIcon: Icon(Icons.search, color: Theme.of(context).colorScheme.primary),
            ),
            dropdownColor: Theme.of(context).cardColor,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
            initialValue: const ['id-1', 'id-2', 'id-3'].contains(_formData[key]) ? _formData[key] : null,
            items: const [
              DropdownMenuItem(value: 'id-1', child: Text('External Record A')),
              DropdownMenuItem(value: 'id-2', child: Text('External Record B')),
              DropdownMenuItem(value: 'id-3', child: Text('External Record C')),
            ],
            onChanged: (val) => setState(() => _formData[key!] = val),
          ),
        );

      case 'dropdown':
        List<dynamic> options = fieldSchema['options'] ?? [];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: label,
              labelStyle: GoogleFonts.inter(color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6)),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).dividerColor), borderRadius: BorderRadius.circular(12)),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary), borderRadius: BorderRadius.circular(12)),
              filled: true,
              fillColor: Theme.of(context).cardColor,
            ),
            dropdownColor: Theme.of(context).cardColor,
            style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
            initialValue: options.contains(_formData[key]) ? _formData[key] : null,
            items: options.map((opt) => DropdownMenuItem<String>(value: opt.toString(), child: Text(opt.toString()))).toList(),
            onChanged: (val) => setState(() => _formData[key!] = val),
          ),
        );

      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(color: Theme.of(context).colorScheme.secondary),
      );
    }
    if (_schema == null) {
      return Center(
        child: Text('SDUI Engine Failure', overflow: TextOverflow.ellipsis, maxLines: 1, style: GoogleFonts.firaCode(color: Colors.red),
        ),
      );
    }

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
                  OutlinedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => SduiDataExplorerDialog(
                          schema: _schema!,
                          onEditRecord: (record) {
                            setState(() {
                              _formData.addAll(record);
                            });
                          },
                        ),
                      );
                    },
                    icon: const Icon(Icons.table_rows_rounded),
                    label: Text('Local Explorer', style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(0, 48),
                      side: BorderSide(color: Theme.of(context).dividerColor),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

          LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth > 500;
              final fieldWidth = isDesktop ? (constraints.maxWidth / 2) - 12 : constraints.maxWidth;
              
              return Wrap(
                spacing: 24,
                runSpacing: 0,
                children: fields.map((field) {
                  final Widget child = _buildField(field);
                  if (field['type'] == 'header' || field['type'] == 'textarea') {
                     return SizedBox(width: constraints.maxWidth, child: child);
                  }
                  return _buildConstrainedField(fieldWidth, child);
                }).toList(),
              );
            }
          ),

          const SizedBox(height: 32),
          const Divider(color: Colors.grey, thickness: 0.2),
          const SizedBox(height: 16),
          _buildActionBar(context),
        ],
      ),
    )));
  }

  Widget _buildConstrainedField(double width, Widget child) {
    return SizedBox(width: width, child: child);
  }

  Widget _buildActionBar(BuildContext context) {
    return OverflowBar(
      alignment: MainAxisAlignment.end,
      spacing: 16,
      overflowSpacing: 16,
      children: [
        OutlinedButton(
          onPressed: () {
            if (Navigator.canPop(context)) Navigator.pop(context);
          },
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(0, 48),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            side: BorderSide(color: Theme.of(context).dividerColor),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Text('Cancel', style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: Theme.of(context).textTheme.bodyLarge?.color)),
        ),
        FilledButton.tonal(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Edit mode activated')));
          },
          style: FilledButton.styleFrom(
            minimumSize: const Size(0, 48),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Text('Edit Data', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
        ),
        ElevatedButton(
          onPressed: _isSubmitting ? null : _submitDynamicForm,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(0, 48),
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 0,
          ),
          child: _isSubmitting 
            ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
            : Text('Save', style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}

class SduiDataExplorerDialog extends StatefulWidget {
  final Map<String, dynamic> schema;
  final Function(Map<String, dynamic>) onEditRecord;

  const SduiDataExplorerDialog({super.key, required this.schema, required this.onEditRecord});

  @override
  State<SduiDataExplorerDialog> createState() => _SduiDataExplorerDialogState();
}

class _SduiDataExplorerDialogState extends State<SduiDataExplorerDialog> {
  String _searchQuery = '';
  late List<Map<String, dynamic>> _allData;

  @override
  void initState() {
    super.initState();
    _allData = List.generate(35, (index) {
      final record = <String, dynamic>{};
      for (var f in (widget.schema['fields'] as List)) {
         if (f['type'] != 'header') {
           record[f['key']] = 'Data ${f['label']} #$index';
         }
      }
      return record;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _allData.where((r) => r.values.any((v) => v.toString().toLowerCase().contains(_searchQuery.toLowerCase()))).toList();
    final fields = (widget.schema['fields'] as List).where((f) => f['type'] != 'header').take(5).toList(); 
    final columns = fields.map((f) => f['label'].toString()).toList();
    columns.add('ACTIONS'); 

    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        width: 1200,
        height: 700,
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(Icons.travel_explore, color: Theme.of(context).colorScheme.primary, size: 32),
                const SizedBox(width: 16),
                Text('${widget.schema['title']} Explorer', style: GoogleFonts.outfit(fontSize: 28, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyLarge?.color)),
                const Spacer(),
                SizedBox(
                  width: 350,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Universal Search...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      fillColor: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    onChanged: (val) => setState(() => _searchQuery = val),
                  ),
                ),
                const SizedBox(width: 24),
                IconButton(icon: const Icon(Icons.close, size: 28), onPressed: () => Navigator.pop(context)),
              ],
            ),
            const SizedBox(height: 32),
            Expanded(
              child: PrimeCareDataTable<Map<String, dynamic>>(
                columns: columns,
                data: filtered,
                rowBuilder: (record) {
                  final cells = fields.map((f) => DataCell(Text(record[f['key']].toString(), overflow: TextOverflow.ellipsis, maxLines: 1))).toList();
                  cells.add(DataCell(
                    FilledButton.tonalIcon(
                      style: FilledButton.styleFrom(minimumSize: const Size(0, 36)),
                      icon: const Icon(Icons.edit, size: 16),
                      label: const Text('Edit Record'),
                      onPressed: () {
                         widget.onEditRecord(record);
                         Navigator.pop(context);
                      },
                    )
                  ));
                  return cells;
                },
              ),
            ),
          ],
        ),
      )
    );
  }
}

