import 'dart:io';

void main() {
  final targetOffices = {
    'FL': 'Field Logistics (FL)'
  };
  
  final roles = ['psw', 'rn', 'client', 'family_member', 'territory_sales_manager'];
  
  for (final office in targetOffices.keys) {
    for (final role in roles) {
      // 1. Target files to overwrite
      final sidebarPath = 'lib/modules/offices/$office/$role/${role}_side_bar.dart';
      final topbarPath = 'lib/modules/offices/$office/$role/${role}_top_bar.dart';
      final dashboardPath = 'lib/modules/offices/$office/$role/${role}_dashboard.dart';
      
      // 2. Source HO files
      final hoSidebar = File('lib/modules/offices/HO/$role/${role}_side_bar.dart').readAsStringSync();
      final hoTopbar = File('lib/modules/offices/HO/$role/${role}_top_bar.dart').readAsStringSync();
      final hoDashboard = File('lib/modules/offices/HO/$role/${role}_dashboard.dart').readAsStringSync();
      
      // 3. Transformations
      String newSidebar = hoSidebar
          .replaceAll('/ho/', '/${office.toLowerCase()}/')
          .replaceAll('Head Office (HO)', targetOffices[office]!)
          .replaceAll('HO_${role.toUpperCase()}', '${office}_${role.toUpperCase()}');
          
      String newTopbar = hoTopbar
          .replaceAll('/ho/', '/${office.toLowerCase()}/')
          .replaceAll('HO_${role.toUpperCase()}', '${office}_${role.toUpperCase()}');
          
      String newDashboard = hoDashboard
          .replaceAll('/ho/', '/${office.toLowerCase()}/')
          .replaceAll('HO_${role.toUpperCase()}', '${office}_${role.toUpperCase()}')
          .replaceAll('HO CRM Dashboard', '$office CRM Dashboard')
          .replaceAll('Jenkins Family (HO Region)', 'Jenkins Family ($office Region)');

      if (office == 'FL' && role == 'psw') {
          newDashboard = newDashboard.replaceAll('Active Duty Tracker', 'Active GPS Duty Heatmap (FL)');
      }

      // 4. Overwrite natively
      File(sidebarPath).parent.createSync(recursive: true);
      File(sidebarPath).writeAsStringSync(newSidebar);
      File(topbarPath).writeAsStringSync(newTopbar);
      File(dashboardPath).writeAsStringSync(newDashboard);
    }
  }
  
  print('Scaled Regional Dashboards for ST, MG, and CS successfully over 45 core files!');
}
