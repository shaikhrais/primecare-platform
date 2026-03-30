import 'dart:io';

void main() {
  final offices = ['HO', 'BD', 'FL', 'CT', 'ST', 'MG', 'CS'];
  final roles = ['psw', 'rn', 'client', 'family_member', 'territory_sales_manager'];
  final basePath = 'lib/modules/offices';

  for (final office in offices) {
    for (final role in roles) {
      final layoutPath = '$basePath/$office/$role/${role}_layout.dart';
      final file = File(layoutPath);
      
      String titleCaseRole = role[0].toUpperCase() + role.substring(1).toLowerCase();
      String classNamePrefix = "$titleCaseRole";
      
      final content = '''
import 'package:flutter/material.dart';
import '../../../../core/role_templates/base_role_layout.dart';
import '${role}_side_bar.dart';
import '${role}_top_bar.dart';

class ${classNamePrefix}LayoutWidget extends BaseRoleLayout {
  final Widget childContent;

  const \${classNamePrefix}LayoutWidget({
    super.key,
    required this.childContent,
  });

  @override
  Widget buildSideBar(BuildContext context) => const ${classNamePrefix}Side_barWidget();

  @override
  Widget buildTopBar(BuildContext context) => const ${classNamePrefix}Top_barWidget();

  @override
  Widget buildContent(BuildContext context) => childContent;
}
''';
      file.writeAsStringSync(content);
    }
  }
  print('Fixed all 35 Layout bindings safely and explicitly.');
}
