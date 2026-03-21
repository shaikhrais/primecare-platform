const fs = require('fs');

const wfPath = '../../packages/primecare_ui/lib/src/components/primecare_wizard_flow.dart';
if (fs.existsSync(wfPath)) {
    let wf = fs.readFileSync(wfPath, 'utf8');
    wf = wf.replace(/const EdgeInsets\.only\(bottom: PrimeCareSpacing\.xl\),/g, 'SizedBox(height: PrimeCareSpacing.xl),');
    wf = wf.replace(/t\.primary/g, 'Theme.of(context).primaryColor');
    wf = wf.replace(/t\.textPrimary/g, 'Theme.of(context).colorScheme.onSurface');
    fs.writeFileSync(wfPath, wf);
}

const scPath = '../../packages/primecare_ui/lib/src/layouts/primecare_scaffold.dart';
if (fs.existsSync(scPath)) {
    let sc = fs.readFileSync(scPath, 'utf8');
    sc = sc.replace(/context\.pTheme\.surface/g, 'context.pTheme.surfaceElevated');
    fs.writeFileSync(scPath, sc);
}

const stPath = 'lib/features/psw/psw_shift_tasks_screen.dart';
if (fs.existsSync(stPath)) {
    let st = fs.readFileSync(stPath, 'utf8');
    st = st.replace(/PrimeCareRow\(\s*alignment:/g, 'Align(alignment:');
    fs.writeFileSync(stPath, st);
}

const pduPath = '../../packages/primecare_ui/lib/src/primecare_data_ui.dart';
if (fs.existsSync(pduPath)) {
    let pdu = fs.readFileSync(pduPath, 'utf8');
    if (!pdu.includes('primecare_card.dart')) {
        pdu = "import 'components/primecare_card.dart';\nimport 'components/primecare_button.dart';\n" + pdu;
    }
    fs.writeFileSync(pduPath, pdu);
}

const sduPath = '../../packages/primecare_ui/lib/src/sdui_engine.dart';
if (fs.existsSync(sduPath)) {
    let sdu = fs.readFileSync(sduPath, 'utf8');
    if (!sdu.includes('primecare_card.dart')) {
        sdu = "import 'components/primecare_card.dart';\nimport 'components/primecare_button.dart';\n" + sdu;
    }
    fs.writeFileSync(sduPath, sdu);
}
console.log('Dart AST Native Patches Applied successfully.');
