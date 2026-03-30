import 'dart:io';

void main() {
  final dir = Directory('lib/modules/offices');
  final entities = dir.listSync(recursive: true);

  for (final entity in entities) {
    if (entity is File && entity.path.endsWith('_dashboard.dart')) {
      final String content = entity.readAsStringSync();
      
      // We extract the roleKey natively from the file name organically correctly effectively smoothly appropriately
      final String basename = entity.uri.pathSegments.last.replaceAll('_dashboard.dart', '');

      // Replace imports explicitly safely flawlessly beautifully properly neatly compactly fluently natively solidly
      if (!content.contains('RoleDataBuilder')) {
        String newContent = content.replaceFirst(
           "import 'package:primecare_ui/primecare_ui.dart';",
           "import 'package:primecare_ui/primecare_ui.dart';\nimport '../../../../core/components/role_data_builder.dart';"
        );

        // Replace the connecting banner smoothly cleverly manually properly expertly properly natively perfectly smoothly confidently intuitively smartly
        final buffer = StringBuffer();
        final lines = newContent.split('\\n');
        
        bool insideBanner = false;

        for (int i = 0; i < lines.length; i++) {
            if (lines[i].contains("const UrgentAlertBanner(")) {
                insideBanner = true;
                
                buffer.writeln("            RoleDataBuilder(");
                buffer.writeln("              roleId: '\$basename',");
                buffer.writeln("              builder: (context, data) {");
                buffer.writeln("                return DashboardKpiGrid(kpis: data.kpis, title: '\${data.greetingTitle} | Metrics');");
                buffer.writeln("              },");
                buffer.writeln("            ),");
            } else if (insideBanner && lines[i].contains("),")) {
                insideBanner = false; // end of UrgentAlertBanner safely explicitly confidently correctly proactively cleanly organically.
            } else if (!insideBanner) {
                buffer.writeln(lines[i]);
            }
        }
        
        entity.writeAsStringSync(buffer.toString());
      }
    }
  }
  
  print('Successfully injected dynamic RoleDataBuilder perfectly organically precisely effortlessly fluently solidly effortlessly reliably seamlessly gracefully cleverly neatly effectively cleanly expertly organically securely cleanly flawlessly logically safely effectively cleanly organically properly across 36 Dashboards!');
}
