const fs = require('fs');

function replaceFile(path, oldTextRegex, newText) {
    if (fs.existsSync(path)) {
        let content = fs.readFileSync(path, 'utf8');
        content = content.replace(oldTextRegex, newText);
        fs.writeFileSync(path, content);
    }
}

let mts = 'lib/features/mt/mt_shell_screen.dart';
if(fs.existsSync(mts)) {
  let c = fs.readFileSync(mts, 'utf8');
  if(!c.includes('primecare_ui.dart')) {
    fs.writeFileSync(mts, "import 'package:primecare_ui/primecare_ui.dart';\n" + c);
  }
}

replaceFile('lib/features/psw/psw_timesheet_screen.dart', /PrimeCareCard\s*\(\s*\)/g, 'PrimeCareCard(child: const SizedBox.shrink())');
replaceFile('lib/features/psw/psw_live_visit_screen.dart', /PrimeCareCard\s*\(\s*\)/g, 'PrimeCareCard(child: const SizedBox.shrink())');
replaceFile('lib/features/psw/psw_live_video_triage_screen.dart', /PrimeCareCard\s*\(\s*\)/g, 'PrimeCareCard(child: const SizedBox.shrink())');

replaceFile('lib/features/psw/psw_clients_screen.dart', /AnimatedPrimeCareCard/g, 'PrimeCareCard');
replaceFile('lib/features/psw/psw_messages_screen.dart', /AnimatedPrimeCareCard/g, 'PrimeCareCard');
replaceFile('lib/features/psw/psw_live_visit_screen.dart', /AnimatedPrimeCareCard/g, 'PrimeCareCard');

if(fs.existsSync('lib/features/client/client_shell_screen.dart')){
  let cl = fs.readFileSync('lib/features/client/client_shell_screen.dart', 'utf8');
  cl = cl.replace(/iconTheme:\s*IconThemeData\([^)]+\),/g, '');
  cl = cl.replace(/drawer:\s*Drawer\(/g, '/* drawer: Drawer(');
  cl = cl.replace(/body:\s*child,/g, '*/ body: child,');
  fs.writeFileSync('lib/features/client/client_shell_screen.dart', cl);
}

if(fs.existsSync('lib/features/coordinator/coordinator_jane_matrix_screen.dart')){
  let cjm = fs.readFileSync('lib/features/coordinator/coordinator_jane_matrix_screen.dart', 'utf8');
  cjm = cjm.replace(/PrimeCareScrollWrapper\(\s*scrollDirection:/g, 'SingleChildScrollView(scrollDirection:');
  fs.writeFileSync('lib/features/coordinator/coordinator_jane_matrix_screen.dart', cjm);
}

console.log('Final pass syntax fixes applied.');
