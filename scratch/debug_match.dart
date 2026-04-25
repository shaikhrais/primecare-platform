String toSnakeCase(String text) {
  return text.replaceAllMapped(
    RegExp(r'([A-Z])'),
    (m) => '_${m[1]!.toLowerCase()}',
  );
}

final officeRoles = {
  'marketing': [
    'localMarketingManager',
    'communityOutreach',
    'territorySalesManager',
  ],
};

Map<String, String>? findRoleMatch(String key) {
  for (final office in officeRoles.keys) {
    for (final role in officeRoles[office]!) {
      final snakeRole = toSnakeCase(role);

      // Check exact role or snake role
      if (key == role || key == snakeRole)
        return {'office': office, 'role': snakeRole};

      // Check if key starts with role prefix
      if (key.startsWith('${snakeRole}_'))
        return {'office': office, 'role': snakeRole};
      if (key.startsWith('${role}_'))
        return {'office': office, 'role': snakeRole};

      // Check if key is role_dashboard
      if (key == '${role}_dashboard' || key == '${snakeRole}_dashboard')
        return {'office': office, 'role': snakeRole};
    }
  }
  return null;
}

void main() {
  String key = 'local_marketing_manager_assets_screen';
  print('Key: $key');
  print('Snake: ${toSnakeCase('localMarketingManager')}');
  var match = findRoleMatch(key);
  print('Match: $match');
}
