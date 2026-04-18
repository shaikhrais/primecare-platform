import 'dart:io';

void main() {
  print('Starting Initial Prisma Sync into Governance Engine...');
  
  final schemaPath = 'packages/database/generated/client/schema.prisma';
  final dataMapPath = '.agents/governance/data_entry_map.yaml';
  
  if (!File(schemaPath).existsSync()) {
    print('Error: Could not locate schema.prisma at $schemaPath');
    exit(1);
  }

  final schemaLines = File(schemaPath).readAsLinesSync();
  
  String? currentModel;
  final List<String> fieldYamlEntries = [];
  
  final existingYaml = File(dataMapPath).existsSync() ? File(dataMapPath).readAsStringSync() : '';
  bool isFirstEntry = existingYaml.isEmpty;
  
  if (isFirstEntry) {
    fieldYamlEntries.add('fields:');
  }

  final scalarTypes = {'String', 'Boolean', 'Int', 'BigInt', 'Float', 'Decimal', 'DateTime', 'Json', 'Bytes'};

  for (final line in schemaLines) {
    final trimmed = line.trim();
    if (trimmed.startsWith('model ')) {
      currentModel = trimmed.substring(6).split(' ').first;
    } else if (trimmed.startsWith('}') && currentModel != null) {
      currentModel = null;
    } else if (currentModel != null && trimmed.isNotEmpty && !trimmed.startsWith('//') && !trimmed.startsWith('@@')) {
      final parts = trimmed.split(RegExp(r'\s+'));
      if (parts.length >= 2) {
        final fieldName = parts[0];
        String fieldType = parts[1];
        
        // Remove modifiers
        final baseType = fieldType.replaceAll('?', '').replaceAll('[]', '');
        
        if (scalarTypes.contains(baseType) || fieldType.contains('@db.')) {
          final entryId = "\${currentModel.toLowerCase()}_\${fieldName}_input";
          
          if (!existingYaml.contains('id: "$entryId"')) {
            fieldYamlEntries.add('''
  - id: "$entryId"
    page: "UNMAPPED_SYNC"
    linked_intent: "UNMAPPED_SYNC"
    validation: "auto_sync_type_$baseType"
    api_endpoint: "SYNC PENDING"
    service_method: "SYNC PENDING"
    database_table: "$currentModel"
    database_column: "$fieldName"''');
          }
        }
      }
    }
  }

  if (fieldYamlEntries.isNotEmpty && fieldYamlEntries.length > (isFirstEntry ? 1 : 0)) {
    final sink = File(dataMapPath).openWrite(mode: FileMode.append);
    for (final entry in fieldYamlEntries) {
      if (entry.isNotEmpty) sink.writeln(entry);
    }
    sink.close();
    print('Successfully synced \${fieldYamlEntries.length} schema fields into the Data Entry Map.');
  } else {
    print('No new fields to sync.');
  }
}
