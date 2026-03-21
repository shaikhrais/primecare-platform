const fs = require('fs');
const path = require('path');

console.log('Patching MT feature module syntax natively...');

// 1. mt_shell_screen.dart
let f = 'lib/features/mt/mt_shell_screen.dart';
if (fs.existsSync(f)) {
    let c = fs.readFileSync(f, 'utf8');
    if (!c.includes('package:primecare_ui/primecare_ui.dart')) {
        c = "import 'package:primecare_ui/primecare_ui.dart';\n" + c;
        fs.writeFileSync(f, c);
    }
}

// 2 & 3. mt_dashboard_screen.dart
f = 'lib/features/mt/mt_dashboard_screen.dart';
if (fs.existsSync(f)) {
    let c = fs.readFileSync(f, 'utf8');
    c = c.replace(/defaultIcon:\s*(Icons\.[a-zA-Z0-9_]+)/g, 'child: Icon($1, color: Colors.white)');
    c = c.replace(/PrimeCareCard\(\s*\)/g, 'PrimeCareCard(child: const SizedBox.shrink())');
    fs.writeFileSync(f, c);
}

// 4. Removing iconTheme from PrimeCareNavBar globally in MT features
const mtFiles = [
    'lib/features/mt/mt_client_profile_screen.dart',
    'lib/features/mt/mt_soap_notes_screen.dart',
    'lib/features/mt/mt_intake_forms_screen.dart',
    'lib/features/mt/mt_invoice_screen.dart',
    'lib/features/mt/mt_credentials_screen.dart'
];

for(let file of mtFiles) {
    if(fs.existsSync(file)) {
        let content = fs.readFileSync(file, 'utf8');
        // Match iconTheme: IconThemeData(color: PrimeCareColors.radarDark),
        content = content.replace(/iconTheme:\s*IconThemeData\([^)]+\),?/g, '');
        fs.writeFileSync(file, content);
    }
}

console.log('MT Dart patches injected successfully.');
