import 'dart:io';

void main(List<String> args) {
  print('--- PrimeCare Feature Generator ---');

  String intentId = '';
  String intentGoal = '';
  String pageRoute = '';
  String pageName = '';
  String pageRole = '';
  String dbTable = '';
  String fieldName = '';

  if (args.length >= 7) {
    intentId = args[0];
    intentGoal = args[1];
    pageRoute = args[2];
    pageName = args[3];
    pageRole = args[4];
    dbTable = args[5];
    fieldName = args[6];
  } else {
    stdout.write('What is the Intent ID? (e.g. create_shift): ');
    intentId = stdin.readLineSync() ?? '';
    
    stdout.write('What is the Business Goal? (e.g. Allow managers to create shifts): ');
    intentGoal = stdin.readLineSync() ?? '';
    
    stdout.write('What is the Route / Page Name path? (e.g. /manager/create-shift): ');
    pageRoute = stdin.readLineSync() ?? '';
    
    stdout.write('What is the Flutter UI Component Name? (e.g. CreateShiftForm): ');
    pageName = stdin.readLineSync() ?? '';
    
    stdout.write('What role is allowed? (e.g. manager_portal): ');
    pageRole = stdin.readLineSync() ?? '';
    
    stdout.write('Which Prisma Database Table does this modify? (e.g. Shift): ');
    dbTable = stdin.readLineSync() ?? '';

    stdout.write('Enter one primary field ID to track (e.g. shift_date_input): ');
    fieldName = stdin.readLineSync() ?? '';
  }

  if (intentId.isEmpty || pageName.isEmpty) {
    print('Error: Invalid inputs.');
    exit(1);
  }

  print('\\nGenerating feature mapping...');

  final intentPath = '.agents/governance/intent_register.yaml';
  final pagePath = '.agents/governance/page_inventory.yaml';
  final dataMapPath = '.agents/governance/data_entry_map.yaml';

  // 1. Append Intent
  var intentFile = File(intentPath);
  if (intentFile.existsSync()) {
    String intStr = intentFile.readAsStringSync();
    if (!intStr.contains('id: "$intentId"')) {
      intentFile.writeAsStringSync('''
  
  - id: "$intentId"
    business_goal: "$intentGoal"
    status: "active"
    implementation_status: "pending"
''', mode: FileMode.append);
    print('✓ Added intent to $intentPath');
    } else {
      print('⚠ Intent $intentId already exists.');
    }
  }

  // 2. Append Page
  String pageIdStr = pageName.replaceAll(RegExp(r'(?<=[a-z])(?=[A-Z])'), '_').toLowerCase();
  var pageFile = File(pagePath);
  if (pageFile.existsSync()) {
    String pageStr = pageFile.readAsStringSync();
    if (!pageStr.contains('id: "$pageIdStr"')) {
      pageFile.writeAsStringSync('''
  
  - id: "$pageIdStr"
    route: "$pageRoute"
    name: "$pageName"
    role_allowed: ["$pageRole"]
    actions: ["submit"]
    linked_intent: "$intentId"
    implementation_status: "pending"
''', mode: FileMode.append);
    print('✓ Added page to $pagePath');
    } else {
      print('⚠ Page $pageIdStr already exists.');
    }
  }

  // 3. Append Data Map Field
  var dataMapFile = File(dataMapPath);
  if (dataMapFile.existsSync()) {
    String dataStr = dataMapFile.readAsStringSync();
    if (!dataStr.contains('id: "$fieldName"') || !dataStr.contains('page: "$pageIdStr"')) {
      dataMapFile.writeAsStringSync('''
  
  - id: "$fieldName"
    page: "$pageIdStr"
    linked_intent: "$intentId"
    validation: "required"
    api_endpoint: "POST /api/v1/${dbTable.toLowerCase()}s"
    service_method: "${dbTable}Service.create"
    database_table: "$dbTable"
    database_column: "${fieldName.replaceAll("_input", "")}"
    implementation_status: "pending"
''', mode: FileMode.append);
    print('✓ Added field to $dataMapPath');
    } else {
      print('⚠ Field $fieldName already mapped to $pageIdStr.');
    }
  }

  // 4. Scaffold UI Form
  String fileName = pageIdStr + '.dart';
  String formDirPath = 'packages/factory_system/primecare_ui/lib/src/components/forms/generated';
  Directory(formDirPath).createSync(recursive: true);
  
  if (File('$formDirPath/$fileName').existsSync()) {
    print('⚠ Scaffold file already exists at $formDirPath/$fileName. Skipping.');
  } else {
  
  String formContent = '''import 'package:flutter/material.dart';

class \$pageName extends StatelessWidget {
  const \$pageName({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$pageName Planned View', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 16),
          // Scaffolded field
          TextFormField(
            key: const Key('$fieldName'),
            decoration: const InputDecoration(labelText: '$fieldName Field'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
''';

  final scaffoldFile = File('$formDirPath/$fileName');
  scaffoldFile.writeAsStringSync(formContent);
  print('✓ Scaffolded UI code at ${scaffoldFile.path}');
  }

  print('\\nSuccess! Feature defined as pending. Run the reconciliation engine later to verify.');
}
