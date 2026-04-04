import os

BASE_DIR = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\apps\primecare_v4\lib\features"

def pascal_case(s):
    return ''.join(word.capitalize() for word in s.split('-'))

def camel_case(s):
    p = pascal_case(s)
    return p[0].lower() + p[1:] if p else p

def generate_feature(feature_id, feature_type):
    # Determine type mapping
    if 'scheduling' in feature_id:
        domain = 'Scheduling'
        dto_fields = "final List<String> views; final int conflicts; final String primaryResource;"
    elif 'pharmacy' in feature_id:
        domain = 'Pharmacy'
        dto_fields = "final List<String> inventoryAlerts; final int prescriptionsPending;"
    elif 'analytics' in feature_id:
        domain = 'Analytics'
        dto_fields = "final List<String> reportsAvailable; final String aiForecast;"
    else:
        domain = 'Messaging'
        dto_fields = "final int unreadCount; final String encryption; final List<String> activeThreads;"
        
    feature_name = feature_id.replace('-', '_')
    pascal_name = pascal_case(feature_id)
    
    # Create directories
    dirs = [
        f"{BASE_DIR}/{feature_name}/domain/models",
        f"{BASE_DIR}/{feature_name}/data/dtos",
        f"{BASE_DIR}/{feature_name}/data/mappers",
        f"{BASE_DIR}/{feature_name}/data/adapters",
        f"{BASE_DIR}/{feature_name}/presentation"
    ]
    for d in dirs:
        os.makedirs(d, exist_ok=True)
        
    # Write ViewModel
    vm_path = f"{BASE_DIR}/{feature_name}/domain/models/{feature_name}_view_model.dart"
    with open(vm_path, "w", encoding="utf-8") as f:
        f.write(f'''class {pascal_name}ViewModel {{
  final String title;
  final String status;
  {dto_fields}
  
  {pascal_name}ViewModel({{
    required this.title,
    required this.status,
  }});
}}
''')

    # Write DTO
    dto_path = f"{BASE_DIR}/{feature_name}/data/dtos/{feature_name}_dto.dart"
    with open(dto_path, "w", encoding="utf-8") as f:
        f.write(f'''class {pascal_name}Dto {{
  final String id;
  final String type;
  final String title;
  final String status;
  
  {pascal_name}Dto.fromJson(Map<String, dynamic> json) 
    : id = json['id'] ?? '',
      type = json['type'] ?? '',
      title = json['title'] ?? '',
      status = json['status'] ?? '';
}}
''')

    # Write Mapper
    mapper_path = f"{BASE_DIR}/{feature_name}/data/mappers/{feature_name}_mapper.dart"
    with open(mapper_path, "w", encoding="utf-8") as f:
        f.write(f'''import '../dtos/{feature_name}_dto.dart';
import '../../domain/models/{feature_name}_view_model.dart';

class {pascal_name}Mapper {{
  static {pascal_name}ViewModel fromApi({pascal_name}Dto dto) {{
    return {pascal_name}ViewModel(
      title: dto.title,
      status: dto.status,
    );
  }}
}}
''')

    # Write Adapter
    adapter_path = f"{BASE_DIR}/{feature_name}/data/adapters/{feature_name}_adapter.dart"
    with open(adapter_path, "w", encoding="utf-8") as f:
        f.write(f'''import '../mappers/{feature_name}_mapper.dart';

class {pascal_name}Adapter {{
  Future<void> getData() async {{
     // Interacts with /v1/primecare/api/{feature_id}
  }}
}}
''')

    # Write Presentation Screen
    screen_path = f"{BASE_DIR}/{feature_name}/presentation/{feature_name}_screen.dart"
    with open(screen_path, "w", encoding="utf-8") as f:
        f.write(f'''import 'package:flutter/material.dart';

class {pascal_name}Screen extends StatelessWidget {{
  const {pascal_name}Screen({{Key? key}}) : super(key: key);

  @override
  Widget build(BuildContext context) {{
    return Scaffold(
      appBar: AppBar(title: const Text('{domain} Hub')),
      body: const Center(
        child: Text('{pascal_name} Component Hydrated!'),
      ),
    );
  }}
}}
''')

print("Starting generation of the 40 pending clinical archetypes...")

seed = 111
for i in range(111, 151):
    if i % 4 == 0:
        feature_id = f"stitch-scheduling-00{i}"
        generate_feature(feature_id, 'CALENDAR')
    elif i % 4 == 1:
        feature_id = f"stitch-pharmacy-00{i}"
        generate_feature(feature_id, 'DISPENSARY')
    elif i % 4 == 2:
        feature_id = f"stitch-analytics-00{i}"
        generate_feature(feature_id, 'ANALYTICS')
    else:
        feature_id = f"stitch-messaging-00{i}"
        generate_feature(feature_id, 'COMMUNICATION')

print(f"Generated 40 feature adapters from {seed} to 150!")
